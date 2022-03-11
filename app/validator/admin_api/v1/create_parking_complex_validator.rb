class AdminApi::V1::CreateParkingComplexValidator
  include Helper::BasicHelper
  include ActiveModel::Model

  attr_accessor(
    :name
  )

  validate :name_exist, :required

  def submit
    persist!
  end

  private

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:name, REQUIRED_MESSAGE) if name.blank?
  end

  def name_exist
    errors.add(:name, NAME_EXIST_MESSAGE) if ParkingComplex.exists?(name: name)
  end
end

