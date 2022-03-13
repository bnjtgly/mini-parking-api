class AdminApi::V1::CreateCustomerValidator
  include Helper::BasicHelper
  include ActiveModel::Model

  attr_accessor(
    :vehicle_type_id,
    :complete_name,
    :plate_number
  )

  validate :required, :plate_number_exist, :valid_name, :valid_vehicle_type

  def submit
    persist!
  end

  private

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:vehicle_type_id, REQUIRED_MESSAGE) if vehicle_type_id.blank?
    errors.add(:complete_name, REQUIRED_MESSAGE) if complete_name.blank?
    errors.add(:plate_number, REQUIRED_MESSAGE) if plate_number.blank?
  end

  def plate_number_exist
    errors.add(:plate_number, 'Please try again. This plate number was already assign to another customer.') if Customer.exists?(plate_number: plate_number)
  end

  def valid_name
    if valid_english_alphabets?(complete_name).eql?(false)
      errors.add(:complete_name, "#{PLEASE_CHANGE_MESSAGE} #{ENGLISH_ALPHABETS_ONLY_MESSAGE}")
    end
  end

  def valid_vehicle_type
    unless vehicle_type_id.blank?
      domain_reference = SubEntity.joins(:entity).where(entities: { entity_number: 1101 }, sub_entities: { id: vehicle_type_id }).first
      unless domain_reference
        references = SubEntity.joins(:entity).where(entities: { entity_number: 1101 }, sub_entities: { status: 'Active' })
        errors.add(:vehicle_type_id, "#{PLEASE_CHANGE_MESSAGE} Valid values are #{references.pluck(:value_str).to_sentence}.")
      end
    end
  end
end

