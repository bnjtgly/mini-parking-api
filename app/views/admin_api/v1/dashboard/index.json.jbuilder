json.data do
  json.parking_complex do
    json.total_parking_spaces @parking_complex.count
  end
  json.parking_slots do
    json.total_parking_slots @parking_slots.count
    json.available_slots @available_slots
    json.occupied_slots @occupied_slots
  end
  json.invoices do
    json.total_eanings @total_earnings
    json.today_earnings @today_earnings
  end
end




