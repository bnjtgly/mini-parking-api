class ParkingComplex < ApplicationRecord
  has_many :parking_slots, dependent: :destroy
  has_many :entry_points, dependent: :destroy
end
