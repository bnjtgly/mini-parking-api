json.data do
  json.array! @customers.each do |data|
    json.customer_id data.id
    json.vehicle_type data.vehicle_type_ref.display
    json.complete_name data.complete_name
    json.plate_number data.plate_number
    json.created_at data.created_at
    json.updated_at data.updated_at
  end
end