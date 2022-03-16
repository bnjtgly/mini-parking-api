json.data do
  json.slot_entrypoints do
    json.array! @slot_entrypoints.each do |data|
      json.slot_entrypoint_id data.id
      json.parking_complex data.parking_slot.parking_complex.name
      json.parking_slot data.parking_slot.name
      json.entry_point data.entry_point.name
      json.distance data.distance
    end
  end
end




