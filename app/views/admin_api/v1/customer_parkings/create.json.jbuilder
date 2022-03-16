json.data do
  json.customer_parking do
    json.user_parking_id @customer_parking.id
    json.customer_id @customer_parking.customer_id
    json.parking_slot @customer_parking.parking_slot.name
    json.parking_slot_status @customer_parking.parking_slot.parking_slot_status_ref.display
    json.parking_status @customer_parking.parking_status_ref.display
    json.is_returnee @customer_parking.is_returnee
    json.current_flat_rate @customer_parking.current_flat_rate
    json.accumulated_hours @customer_parking.accumulated_hours
    json.valid_from @customer_parking.valid_from
    json.valid_thru @customer_parking.valid_thru
    json.invoice do
      if @customer_parking.invoice
        json.transaction_status @customer_parking.invoice.transaction_status_ref.display
        json.is_flatrate_settled @customer_parking.invoice.is_flatrate_settled
        json.parked_hours @customer_parking.invoice.parked_hours
        json.parking_fee @customer_parking.invoice.parking_fee
      else
        json.null!
      end
    end
  end
end