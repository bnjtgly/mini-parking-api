json.data do
  json.customer_parkings do
    json.array! @customer_parkings.each do |data|
      json.user_parking_id data.id
      json.customer_id data.customer.id
      json.parking_slot data.parking_slot.name
      json.parking_status data.parking_status_ref.display
      json.is_returnee data.is_returnee
      json.current_flat_rate data.current_flat_rate
      json.valid_from data.valid_from
      json.valid_thru data.valid_thru
    end
  end
end