json.data do
  json.latest_parkings do
    json.array! @customer_parkings.each do |data|
      json.id data.id
      json.customer data.customer.complete_name
      json.customer_short data.customer.complete_name.first
      json.parking_slot data.parking_slot.name
      json.parking_fee data.invoice.parking_fee
      json.status data.parking_status_ref.display
      json.created_at data.created_at
    end
  end
end