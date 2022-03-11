class Customer < ApplicationRecord
  has_many :customer_parkings, dependent: :destroy

  # Sub Entities Association
  # List all sub_entities columns in users table.
  belongs_to :vehicle_type_ref, class_name: 'SubEntity', foreign_key: 'vehicle_type_id', optional: true

end
