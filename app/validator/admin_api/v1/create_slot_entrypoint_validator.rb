class AdminApi::V1::CreateSlotEntrypointValidator
  include Helper::BasicHelper
  include ActiveModel::Model

  attr_accessor(
    :parking_slot_id,
    :entry_point_id,
    :distance
  )




  validate :required, :parking_slot_id_exist, :entry_point_id_exist, :valid_distance

  def submit
    init
    persist!
  end

  private

  def init
    @parking_slot = ParkingSlot.where(id: parking_slot_id).first
    @entry_point = EntryPoint.where(id: entry_point_id).first
  end

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:parking_slot_id, REQUIRED_MESSAGE) if parking_slot_id.blank?
    errors.add(:entry_point_id, REQUIRED_MESSAGE) if entry_point_id.blank?
    errors.add(:distance, REQUIRED_MESSAGE) if distance.blank?
  end

  def parking_slot_id_exist
    errors.add(:parking_slot_id, NOT_FOUND) unless @parking_slot
  end

  def entry_point_id_exist
    errors.add(:entry_point_id, NOT_FOUND) unless @entry_point
  end

  def valid_distance
    errors.add(:distance, VALID_DISTANCE) unless valid_float?(distance)
  end

end

