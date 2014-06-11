json.id    property.id
json.name  property.name
json.value property.value_decorated_for(current_user)
json.accepted property.accepted

if property.user
  json.user  do |json|
    json_partial! json, 'users/user', user: property.user
  end
  json.created_at property.created_at
end
