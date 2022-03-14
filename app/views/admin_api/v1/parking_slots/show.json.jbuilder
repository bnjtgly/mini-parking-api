json.data do
  json.parking_slots do
    json.parking_slot_id @parking_slot.id
    json.parking_complex @parking_slot.parking_complex.name
    json.parking_slot_type @parking_slot.parking_slot_type_ref.display
    json.parking_slot_status @parking_slot.parking_slot_status_ref.display
    json.slot_name @parking_slot.name
  end
end




