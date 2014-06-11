json.id        property.id
json.name      property.name
json.value     property.value_decorated_for(current_user)
json.change_set do |json|
  json.id property.change_set_id
end
