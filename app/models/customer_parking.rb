class CustomerParking < ApplicationRecord
  belongs_to :parking_slot
  belongs_to :customer
  has_one :invoice, dependent: :destroy

  # Sub Entities Association
  # List all sub_entities columns in users table.
  belongs_to :parking_status_ref, class_name: 'SubEntity', foreign_key: 'parking_status_id', optional: true
end
