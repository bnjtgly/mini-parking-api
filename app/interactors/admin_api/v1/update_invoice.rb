class AdminApi::V1::UpdateInvoice
  include Services::CalculationService
  include Interactor

  delegate :data, to: :context

  def call
    init
    build
  end

  def rollback; end

  private

  def init
    @invoice = Invoice.where(customer_parking_id: context.customer_parking.id).load_async.first
    @customer = Invoice.where(customer_id: context.customer_parking.customer_id).load_async.last
    @customer_parking = CustomerParking.where(id: context.customer_parking.id).load_async.first
    @transaction_status = Entity.where(entity_number: 1401).load_async.first
    @ts_settled = @transaction_status.sub_entities.where(value_str: 'settled').first
    @ts_pending = @transaction_status.sub_entities.where(value_str: 'pending').first
  end

  def build
    flat_rate_fee = 40
    current_flat_rate = @customer_parking.current_flat_rate
    accumulated_hours = @customer_parking.accumulated_hours
    park_out_time = @customer_parking.valid_thru
    parked_hours = (park_out_time - @customer_parking.valid_from) / 1.hour
    parked_hours = parked_hours.ceil
    slot_price = @customer_parking.parking_slot.parking_slot_type_ref.metadata.to_h
    slot_price = slot_price['price'].to_f

    misc_fee = flat_rate_fee
    misc_fee = 0 if @invoice.is_flatrate_settled

    total_fee = misc_fee + normal_rate(accumulated_hours, slot_price)

    if @customer_parking.is_returnee
      if accumulated_hours >= 1
        total_fee = misc_fee + regular_rate(accumulated_hours, slot_price)
      end
    end

    if accumulated_hours >= 24
      total_fee = full_rate(accumulated_hours, slot_price)
    end


    @invoice&.update(
      transaction_status_id: @ts_settled.id,
      is_flatrate_settled: true,
      parked_hours: parked_hours,
      parking_fee: total_fee
    )

    context.invoice = @invoice
  end

  def payload
    {
      customer_id: data[:parking][:customer_id],
      valid_thru: data[:parking][:valid_thru]
    }
  end
end
