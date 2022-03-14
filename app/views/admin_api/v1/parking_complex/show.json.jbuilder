json.data do
  json.parking_complex do
    json.parking_complex_id @parking_complex.id
    json.name @parking_complex.name
    json.slot_summary @slot_type_count

    json.entry_points do
      if @parking_complex.entry_points
        json.array! @parking_complex.entry_points.each do |data|
          json.entry_point_id data.id
          json.parking_complex_id data.parking_complex_id
          json.name data.name
        end
      else
        json.null!
      end
    end

    json.parking_slots do
      if @parking_complex.parking_slots
        json.array! @parking_complex.parking_slots.each do |data|
          json.parking_slot_id data.id
          json.parking_complex data.parking_complex.name
          json.parking_slot_type data.parking_slot_type_ref.display
          json.parking_slot_status data.parking_slot_status_ref.display
          json.slot_name data.name
        end
      else
        json.null!
      end
    end
  end
end




