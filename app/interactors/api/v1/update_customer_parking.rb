# frozen_string_literal: true

class Api::V1::UpdateCustomerParking
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
    @customer_parking = CustomerParking.where(customer_id: data[:parking][:customer_id], valid_thru: nil).load_async.first
    @transaction_status = Entity.where(entity_name: 'Transaction Status').load_async.first
    @ts_pending = @transaction_status.sub_entities.where(value_str: 'pending').first
    @ts_settled = @transaction_status.sub_entities.where(value_str: 'settled').first
    @unpark = SubEntity.where(value_str: 'unparked').load_async.first

    context.fail!(error: { customer_id: ['Please try again. Record not found.'] }) unless @customer_parking
  end

  def build
    # park_out_time = Time.now
    park_out_time = payload[:valid_thru] ? Time.zone.parse(payload[:valid_thru]).utc : Time.now.utc
    parked_hours = (park_out_time - @customer_parking.valid_from) / 1.hour
    parked_hours = parked_hours.ceil
    current_flat_rate = @customer_parking.current_flat_rate
    accumulated_hours = current_flat_rate - parked_hours
    accumulated_hours = accumulated_hours <= 0 ? 0 : accumulated_hours

    process_invoice(parked_hours, current_flat_rate) if @customer_parking.update(valid_thru: park_out_time, parking_status_id: @unpark.id, current_flat_rate: accumulated_hours)

    context.customer_parking = @customer_parking
  end

  def process_invoice(parked_hours, current_flat_rate)
    flat_rate_time = 3
    total_fee = calculate_fee(parked_hours, @customer_parking.parking_slot.price)

    if @customer_parking.is_returnee
      total_fee = 0 if current_flat_rate <= flat_rate_time
      total_fee = calculate_fee(flat_rate_time + parked_hours, @customer_parking.parking_slot.price) if current_flat_rate.eql?(0)
    end

    @customer_parking.create_invoice(transaction_status_id: @ts_settled.id, parked_hours: parked_hours, parking_fee: total_fee)
  end

  def payload
    {
      customer_id: data[:parking][:customer_id],
      valid_thru: data[:parking][:valid_thru]
    }
  end
end
