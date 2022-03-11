json.data do
  json.user do
    json.user_id @user.id
    json.email @user.email
    json.first_name @user.first_name
    json.last_name @user.last_name
    json.complete_name @user.complete_name
    json.created_at @user.created_at
    json.updated_at @user.updated_at
    json.role do
      json.role @user.user_role.role.role_name
    end
  end

  json.api_client do
    if @user.api_client
      json.name @user.api_client.name
    else
      json.null!
    end
  end
end


