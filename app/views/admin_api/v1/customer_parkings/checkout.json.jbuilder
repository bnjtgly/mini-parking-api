json.data do
  json.invoice do
    json.customer @customer_parking_checkout.customer.complete_name
    json.slot_type @customer_parking_checkout.parking_slot.parking_slot_type_ref.display
    json.slot_status @customer_parking_checkout.parking_slot.parking_slot_status_ref.display
    json.slot_name @customer_parking_checkout.parking_slot.name
    json.transaction_status @customer_parking_checkout.invoice.transaction_status_ref.display
    json.parked_hours @customer_parking_checkout.invoice.parked_hours
    json.parking_fee @customer_parking_checkout.invoice.parking_fee
  end
end