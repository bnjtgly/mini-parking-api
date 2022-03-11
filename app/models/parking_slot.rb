class ParkingSlot < ApplicationRecord
  belongs_to :parking_complex
  has_one :customer_parking, dependent: :destroy

  # Sub Entities Association
  # List all sub_entities columns in users table.
  belongs_to :parking_slot_type_ref, class_name: 'SubEntity', foreign_key: 'parking_slot_type_id', optional: true
  belongs_to :parking_slot_status_ref, class_name: 'SubEntity', foreign_key: 'parking_slot_status_id', optional: true
end
