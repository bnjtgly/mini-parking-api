class AdminApi::V1::CreateParkingSlotValidator
  include Helper::BasicHelper
  include ActiveModel::Model

  attr_accessor(
    :parking_complex_id,
    :parking_slot_type_id,
    :parking_slot_status_id,
    :name,
    :entry_point_distance,
    :price
  )

  validate :required, :parking_complex_id_exist, :name_exist, :valid_price, :valid_parking_slot_type_id, :valid_parking_slot_status_id

  def submit
    init
    persist!
  end

  private

  def init
    @parking_complex = ParkingComplex.where(id: parking_complex_id).first
  end

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:parking_complex_id, REQUIRED_MESSAGE) if parking_complex_id.blank?
    errors.add(:parking_slot_type_id, REQUIRED_MESSAGE) if parking_slot_type_id.blank?
    errors.add(:parking_slot_status_id, REQUIRED_MESSAGE) if parking_slot_status_id.blank?
    errors.add(:name, REQUIRED_MESSAGE) if name.blank?
    errors.add(:entry_point_distance, REQUIRED_MESSAGE) if entry_point_distance.blank?
    errors.add(:price, REQUIRED_MESSAGE) if price.blank?
  end

  def parking_complex_id_exist
    errors.add(:parking_complex_id, NOT_FOUND) unless @parking_complex
  end

  def name_exist
    errors.add(:name, 'Please try again. slot name already exist.') if ParkingSlot.exists?(name: name)
    end

  def valid_price
    errors.add(:price, 'Please try again. Not a valid amount.') unless valid_float?(price)
  end

  def valid_parking_slot_type_id
    unless parking_slot_type_id.blank?
      domain_reference = SubEntity.joins(:entity).where(entities: { entity_number: 1001 }, sub_entities: { id: parking_slot_type_id }).first
      unless domain_reference
        references = SubEntity.joins(:entity).where(entities: { entity_number: 1001 }, sub_entities: { status: 'Active' })
        errors.add(:parking_slot_type_id, "#{PLEASE_CHANGE_MESSAGE} Valid values are #{references.pluck(:value_str).to_sentence}.")
      end
    end
  end

  def valid_parking_slot_status_id
    unless parking_slot_status_id.blank?
      domain_reference = SubEntity.joins(:entity).where(entities: { entity_number: 1201 }, sub_entities: { id: parking_slot_status_id }).first
      unless domain_reference
        references = SubEntity.joins(:entity).where(entities: { entity_number: 1201 }, sub_entities: { status: 'Active' })
        errors.add(:parking_slot_status_id, "#{PLEASE_CHANGE_MESSAGE} Valid values are #{references.pluck(:value_str).to_sentence}.")
      end
    end
  end

end

