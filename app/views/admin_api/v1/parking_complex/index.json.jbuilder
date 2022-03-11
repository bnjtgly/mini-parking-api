json.data do
  json.parking_complex do
    json.array! @parking_complexes.each do |data|
      json.parking_complex_id data.id
      json.name data.name
      json.entry_points do
        if data.entry_points
          json.array! data.entry_points.each do |data|
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
end