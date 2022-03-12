json.data do
  json.invoices do
    json.array! @invoices.each do |data|
      json.invoice_id data.id
      json.customer_parking do
        json.customer_parking data.customer_parking.id
        json.customer_id data.customer_parking.customer.id
        json.parking_slot data.customer_parking.parking_slot.name
        json.parking_status data.customer_parking.parking_status_ref.display
        json.is_returnee data.customer_parking.is_returnee
        json.current_flat_rate data.customer_parking.current_flat_rate
        json.valid_from data.customer_parking.valid_from
        json.valid_thru data.customer_parking.valid_thru
      end
      json.transaction_status data.transaction_status_ref.display
      json.parked_hours data.parked_hours
      json.parking_fee data.parking_fee
    end
  end
end


