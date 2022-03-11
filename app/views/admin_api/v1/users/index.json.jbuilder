json.data do
  json.array! @users.each do |data|
    json.user_id data.id
    json.email data.email
    json.first_name data.first_name
    json.last_name data.last_name
    json.complete_name data.complete_name
    json.created_at data.created_at
    json.updated_at data.updated_at
    json.role do
      json.role data.user_role.role.role_name
    end
    if data.api_client
      json.api_client do
        json.id data.api_client.id
        json.name data.api_client.name
      end
    else
      json.api_client nil
    end
  end
end




