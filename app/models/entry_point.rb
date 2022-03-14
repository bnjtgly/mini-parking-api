class EntryPoint < ApplicationRecord
  belongs_to :parking_complex
  has_many :slot_entrypoints, dependent: :destroy
end
