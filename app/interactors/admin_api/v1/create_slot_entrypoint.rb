class AdminApi::V1::CreateSlotEntrypoint
  include Interactor

  delegate :data, to: :context

  def call
    validate!
    build
  end

  def rollback
    context.slot_entrypoint&.destroy
  end

  private

  def build
    @slot_entrypoint = SlotEntrypoint.new(payload)

    ParkingSlot.transaction do
      @slot_entrypoint.save
    end

    context.slot_entrypoint = @parking_slot
  end

  def validate!
    verify = AdminApi::V1::CreateSlotEntrypointValidator.new(payload)

    return true if verify.submit

    context.fail!(error: verify.errors)
  end

  def payload
    {
      parking_slot_id: data[:slot_entrypoint][:parking_slot_id],
      entry_point_id: data[:slot_entrypoint][:entry_point_id],
      distance: data[:slot_entrypoint][:distance]
    }
  end
end


