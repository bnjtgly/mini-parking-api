json.data do
  json.array! @entities.each do |data|
    json.entity_id data.id
    json.entity_number data.entity_number
    json.entity_name data.entity_name
    json.entity_def data.entity_def
    json.sub_entities data.sub_entities
  end
end