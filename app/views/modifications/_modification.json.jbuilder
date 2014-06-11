json.id    modification.id
json.label modification.label

json.vehicle do |json|
  json.id modification.vehicle_id
end

json.part_purchases modification.part_purchases do |json, part_purchase|
  json_partial! json, 'part_purchases/part_purchase', part_purchase: part_purchase
end

json.services modification.services do |json, service|
  json_partial! json, 'services/service', service: service
end

json.properties modification.properties do |json, property|
  json_partial! json, 'modification_properties/modification_property', property: property
end
