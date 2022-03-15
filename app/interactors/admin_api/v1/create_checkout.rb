class AdminApi::V1::CreateCheckout
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
    context.fail!(error: { message: ['Please try again. Record not found.'] }) unless @customer_parking
  end

  def build
    @parking_slot = ParkingSlot.where(id: @customer_parking.parking_slot.id).first
    parking_status_unpark = SubEntity.where(value_str: 'unparked').load_async.first
    park_out_time = payload[:valid_thru] ? Time.zone.parse(payload[:valid_thru]).utc : Time.now.utc
    parked_hours = (park_out_time - @customer_parking.valid_from) / 1.hour
    accumulated_flat_rate = @customer_parking.current_flat_rate - parked_hours.ceil
    accumulated_flat_rate = accumulated_flat_rate <= 0 ? 0 : accumulated_flat_rate
    slot_available = SubEntity.where(value_str: 'available').load_async.first

    if (@customer_parking.current_flat_rate - parked_hours.ceil) < 0
      accumulated_hours = @customer_parking.accumulated_hours + parked_hours.ceil
    else
      accumulated_hours = 0
    end

    @customer_parking&.update(
      valid_thru: park_out_time,
      parking_status_id: parking_status_unpark.id,
      current_flat_rate: accumulated_flat_rate,
      accumulated_hours: accumulated_hours
    )

    @parking_slot.update(parking_slot_status_id: slot_available.id)

    context.customer_parking = @customer_parking
  end

  def payload
    {
      customer_id: data[:parking][:customer_id],
      valid_thru: data[:parking][:valid_thru]
    }
  end

end
