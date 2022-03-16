class SlotEntrypoint < ApplicationRecord
	belongs_to :entry_point
	belongs_to :parking_slot
end
