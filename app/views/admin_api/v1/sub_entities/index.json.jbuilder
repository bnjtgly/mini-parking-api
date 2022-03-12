json.data do
  json.sub_entities do
    json.array! @entity.sub_entities.each do |data|
      json.entity_number @entity.entity_number
      json.entity_name @entity.entity_name
      json.entity_def @entity.entity_def
      json.sub_entity_id data.id
      json.sort_order data.sort_order
      json.display data.display
      json.value_str data.value_str
      json.status data.status
      json.metadata data.metadata.eql?('{}') ? nil : data.metadata
    end
  end
end