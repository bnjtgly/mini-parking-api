class AdminApi::V1::CreateParkingSlot
  include Interactor

  delegate :data, to: :context

  def call
    validate!
    build
  end

  def rollback
    context.parking_slot&.destroy
  end

  private

  def build
    @parking_slot = ParkingSlot.new(payload)
    ParkingSlot.transaction do
      @parking_slot.save
    end

    context.parking_slot = @parking_slot
  end

  def validate!
    verify = AdminApi::V1::CreateParkingSlotValidator.new(payload)

    return true if verify.submit

    context.fail!(error: verify.errors)
  end

  def payload
    {
      parking_complex_id: data[:parking_slot][:parking_complex_id],
      parking_slot_type_id: data[:parking_slot][:parking_slot_type_id],
      parking_slot_status_id: data[:parking_slot][:parking_slot_status_id],
      name: data[:parking_slot][:name],
      entry_point_distance: data[:parking_slot][:entry_point_distance],
      price: data[:parking_slot][:price]
    }
  end
end
