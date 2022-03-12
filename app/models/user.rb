class User < ApplicationRecord
  belongs_to :api_client
  has_one :user_role, dependent: :destroy
  # has_many :customer_parking, dependent: :destroy

  devise :database_authenticatable, :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  before_save :titleize
  before_update :titleize

  audited associated_with: :api_client
  has_associated_audits

  def complete_name
    "#{first_name} #{last_name}".squish
  end

  def titleize
    self.first_name = first_name.try(:downcase).try(:titleize)
    self.last_name = last_name.try(:downcase).try(:titleize)
  end

  def jwt_payload
    self.refresh_token = loop do
      random_key = SecureRandom.uuid
      break random_key unless User.exists?(refresh_token: random_key)
    end
    save_without_auditing

    { 'refresh_token' => refresh_token }
  end
end
