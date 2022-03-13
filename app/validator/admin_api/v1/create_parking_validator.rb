class AdminApi::V1::CreateParkingValidator
  include Helper::BasicHelper
  include ActiveModel::Model

  attr_accessor(
    :customer_id,
    :parking_slot_id,
    :parking_status_id,
    :valid_from,
    :valid_thru
  )

  validate :customer_id_exist, :required, :customer_id_exist, :parking_slot_id_exist, :parking_status_id_exist

  def submit
    persist!
  end

  private

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:customer_id, REQUIRED_MESSAGE) if customer_id.blank?
    errors.add(:parking_slot_id, REQUIRED_MESSAGE) if parking_slot_id.blank?
    errors.add(:parking_status_id, REQUIRED_MESSAGE) if parking_status_id.blank?
  end

  def customer_id_exist
    errors.add(:customer_id, NOT_FOUND) unless Customer.exists?(id: customer_id)
  end

  def parking_slot_id_exist
    errors.add(:parking_slot_id, NOT_FOUND) unless ParkingSlot.exists?(id: parking_slot_id)
  end

  def parking_status_id_exist
    errors.add(:parking_status_id, NOT_FOUND) unless SubEntity.exists?(id: parking_status_id)
  end

  def valid_date
    errors.add(:valid_from, VALID_DATE_MESSAGE) unless valid_date?(valid_from)
    errors.add(:valid_thru, VALID_DATE_MESSAGE) unless valid_date?(valid_from)
  end

  def valid_thru_date
    errors.add(:valid_thru, VALID_THRU_MESSAGE) if valid_thru && !(valid_date?(valid_thru) && valid_thru_date?(valid_thru))
  end
end
