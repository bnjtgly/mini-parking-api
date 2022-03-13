json.data do
  json.user do
    json.customer_id @customer.id
    json.vehicle_type @customer.vehicle_type_ref.display
    json.complete_name @customer.complete_name
    json.plate_number @customer.plate_number
    json.created_at @customer.created_at
    json.updated_at @customer.updated_at

  end
end


