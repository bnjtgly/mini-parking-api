json.data do
  json.customer do
    json.parking_slot_id @parking_slot.id
    json.parking_complex @parking_slot.parking_complex.name
    json.parking_slot_type @parking_slot.parking_slot_type_ref.display
    json.slot_name @parking_slot.name
    json.price @parking_slot.price
    json.entry_point_distance @parking_slot.entry_point_distance
  end
end

