json.id        property.id
json.name      property.name
json.value     property.value_decorated_for(current_user)
json.modification do |json|
  json.id property.modification_id
end
