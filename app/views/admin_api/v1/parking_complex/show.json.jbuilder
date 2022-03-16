json.data do
  json.parking_complex do
    json.parking_complex_id @parking_complex.id
    json.name @parking_complex.name
    json.slot_summary @slot_type_count

    json.entry_points do
      if @parking_complex.entry_points
        json.array! @parking_complex.entry_points.each do |data|
          json.entry_point_id data.id
          json.parking_complex_id data.parking_complex_id
          json.name data.name
        end
      else
        json.null!
      end
    end

    json.parking_slots do
      if @parking_complex.parking_slots
        json.array! @parking_complex.parking_slots.each do |data|
          json.parking_slot_id data.id
          json.parking_complex data.parking_complex.name
          json.parking_slot_type data.parking_slot_type_ref.display
          json.parking_slot_status data.parking_slot_status_ref.display
          json.slot_name data.name
          json.customer_details do
            if data.customer_parking && data.parking_slot_status_ref.display.eql?('Not Available')
              json.test data.customer_parking.id
              json.customer_parking_id data.customer_parking.id
              json.customer_id data.customer_parking.customer.id
              json.customer_name data.customer_parking.customer.complete_name
              json.plate_number data.customer_parking.customer.plate_number
              json.vehicle_type data.customer_parking.customer.vehicle_type_ref.display
              json.is_returnee data.customer_parking.is_returnee
              json.current_flat_rate data.customer_parking.current_flat_rate
              json.accumulated_hours data.customer_parking.accumulated_hours
            else
              json.null!
            end
          end
        end
      else
        json.null!
      end
    end
  end
end




