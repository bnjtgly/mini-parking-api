json.data do
  json.slot_entrypoint do
    json.slot_entrypoint_id @slot_entrypoint.id
    json.parking_slot @slot_entrypoint.parking_slot.name
    json.entry_point @slot_entrypoint.entry_point.name
    json.distance @slot_entrypoint.distance
  end
end