json.data do
  json.parking_slots do
    json.array! @parking_slots.each do |data|
      json.parking_slot_id data.id
      json.parking_complex data.parking_complex.name
      json.parking_slot_type data.parking_slot_type_ref.display
      json.parking_slot_status data.parking_slot_status_ref.display
      json.slot_name data.name
    end
  end
end