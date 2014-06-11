json.id                      comparison_table.id
json.label                   comparison_table.label
json.selected_change_set_ids comparison_table.selected_change_set_ids

json.user do |json|
  json.partial!('users/user', user: comparison_table.user)
end

json.vehicles VehicleDecorator.decorate(comparison_table.vehicles) do |json, vehicle|
  json.id    vehicle.id
  json.label vehicle.label
  json.type  vehicle.vehicle_type
  json.change_sets(vehicle.change_sets) do |json, change_set|
    json.id   change_set.id
    json.name change_set.name
  end
  json.side_view do |json|
    if vehicle.side_view.present?
      json.id      vehicle.side_view.id
      json.thumb_url vehicle.side_view.image.thumb.url
      json.large_url vehicle.side_view.image.large.url
      json.image_dimensions vehicle.side_view.image_dimensions
    end
  end
  json.version do |json|
    json_partial!(json, 'versions/version', version: vehicle.version)
  end
end

json.likes(comparison_table.likes) do |json, like|
  json.id like.id
  json.user_id like.user_id
end

json.saves(comparison_table.saves) do |json, save|
  json.id   save.id
  json.user_id  save.user_id
end

json.likers(comparison_table.likers) do |json, liker|
  json.partial!('users/user', user: liker)
end

json.savers(comparison_table.savers) do |json, saver|
  json.partial!('users/user', user: saver)
end

json.comparison_attributes ComparisonTable::COMPARISON_ATTRIBUTES

json.properties comparison_table.inject_comparison_property_values_for(user)

