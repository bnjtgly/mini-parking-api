json.data do
  json.parking_slot_details do
    json.slot_id @available_slots.id
    json.slot_name @available_slots.name
    json.price "#{@slot_price} per hour"
    json.distance @entry_point_distance
  end
end