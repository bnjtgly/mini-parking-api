json.data do
  json.invoice do
    json.customer @customer_parking.customer.complete_name
    json.slot_type @customer_parking.parking_slot.parking_slot_type_ref.display
    json.slot_name @customer_parking.parking_slot.name
    json.transaction_status @customer_parking.invoice.transaction_status_ref.display
    json.parked_hours @customer_parking.invoice.parked_hours
    json.parking_fee @customer_parking.invoice.parking_fee
  end
end