class AdminApi::V1::CreateInvoiceValidator
  include Helper::BasicHelper
  include ActiveModel::Model

  attr_accessor(
    :customer_parking_id,
    :transaction_status_id,
    :parked_hours,
    :parking_fee
  )

  validates :parked_hours, numericality: { only_integer: true }
  validate :required, :plate_number_exist, :valid_name, :valid_vehicle_type

  def submit
    init
    persist!
  end

  private
  def init
    @customer_parking = CustomerParking.where(id: customer_parking_id).first
  end

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:customer_parking_id, REQUIRED_MESSAGE) if customer_parking_id.blank?
    errors.add(:transaction_status_id, REQUIRED_MESSAGE) if transaction_status_id.blank?
    errors.add(:parked_hours, REQUIRED_MESSAGE) if parked_hours.blank?
    errors.add(:parking_fee, REQUIRED_MESSAGE) if parking_fee.blank?
  end

  def customer_parking_id_exist
    errors.add(:plate_number, NOT_FOUND) unless @customer_parking
  end

  def valid_parking_fee
    errors.add(:price, 'Please try again. Not a valid amount.') unless valid_float?(parking_fee)
  end

  def valid_transaction_status_id
    unless transaction_status_id.blank?
      domain_reference = SubEntity.joins(:entity).where(entities: { entity_number: 1401 }, sub_entities: { id: transaction_status_id }).first
      unless domain_reference
        references = SubEntity.joins(:entity).where(entities: { entity_number: 1401 }, sub_entities: { status: 'Active' })
        errors.add(:transaction_status_id, "#{PLEASE_CHANGE_MESSAGE} Valid values are #{references.pluck(:value_str).to_sentence}.")
      end
    end
  end
end

