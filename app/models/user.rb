class User < ApplicationRecord
  belongs_to :api_client
  has_one :user_role, dependent: :destroy
  # has_many :customer_parking, dependent: :destroy

  devise :database_authenticatable, :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  before_save :titleize
  before_update :titleize

  def complete_name
    "#{first_name} #{last_name}".squish
  end

  def titleize
    self.first_name = first_name.try(:downcase).try(:titleize)
    self.last_name = last_name.try(:downcase).try(:titleize)
  end
end
