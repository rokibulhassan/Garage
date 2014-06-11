json.id                     version.id
json.name                   version.name
json.second_name            version.second_name
json.label                  version.label
json.pending                version.pending
json.rejected               version.rejected
json.production_year        version.production_year
json.production_code        version.production_code
json.body                   version.body
json.transmission_numbers   version.transmission_numbers
json.transmission_type      version.transmission_type
json.market_version_name    version.market_version_name
json.full_identity_data     version.full_identity_data
json.doors                  version.doors
json.energy                 version.energy
json.transmission_details   version.transmission_details
json.show_model_name        version.show_model_name
json.vehicle_type           version.model.vehicle_type

if User.current
  json.current_user_comment version.comment_by_user(User.current)
end
json.random_user_comment version.random_user_comment_as_json

json.generation do |json|
  json.id version.generation.id
end
