json.id                 change_set.id
json.name               change_set.name
json.modification_ids   change_set.modification_ids

json.vehicle do |json|
  json.id change_set.vehicle_id
end

json.services change_set.services do |json, service|
  json_partial! json, 'services/service', service: service
end

json.part_purchases change_set.part_purchases do |json, part_purchase|
  json_partial! json, 'part_purchases/part_purchase', part_purchase: part_purchase
end

json.properties change_set.properties do |json, property|
  json_partial! json, 'change_set_properties/change_set_property', property: property
end
