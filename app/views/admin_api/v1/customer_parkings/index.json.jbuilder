json.data do
  json.customer_parkings do
    json.array! @customer_parkings.each do |data|
      json.user_parking_id data.id
      json.customer_id data.customer.id
      json.parking_slot data.parking_slot.name
      json.parking_status data.parking_status_ref.display
      json.is_returnee data.is_returnee
      json.current_flat_rate data.current_flat_rate
      json.accumulated_hours data.accumulated_hours
      json.valid_from data.valid_from
      json.valid_thru data.valid_thru

      json.invoice do
        if data.invoice
          json.transaction_status data.invoice.transaction_status_ref.display
          json.is_flatrate_settled data.invoice.is_flatrate_settled
          json.parked_hours data.invoice.parked_hours
          json.parking_fee data.invoice.parking_fee
        else
          json.null!
        end
      end
    end
  end
end