json.data do
  json.customers do
    json.array! @customers.each do |data|
      json.customer_id data.id
      json.vehicle_type data.vehicle_type_ref.display
      json.complete_name data.complete_name
      json.plate_number data.plate_number
    end
  end
end