json.id         correction.id
json.value      correction.value
json.corrector do |json|
  json.partial!('users/user', user: correction.corrector)
end
json.version_property_id correction.version_property_id
json.created_at correction.created_at
