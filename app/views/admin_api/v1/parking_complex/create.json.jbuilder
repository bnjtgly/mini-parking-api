json.data do
  json.parking_complex do
    json.parking_complex_id @parking_complex.id
    json.name @parking_complex.name
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
  end
end