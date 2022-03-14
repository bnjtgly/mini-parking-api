json.data do
  json.entry_points do
    json.array! @entry_points.each do |data|
      json.entry_points_id data.id
      json.parking_complex_id data.parking_complex_id
      json.parking_complex data.parking_complex.name
      json.name data.name
    end
  end
end