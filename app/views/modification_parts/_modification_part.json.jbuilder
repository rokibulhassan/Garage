json.id       modification_part.id
json.quantity modification_part.quantity
json.price    modification_part.price
json.main     modification_part.main

if modification_part.part_id
  json.part do |json|
    json.id                     modification_part.part.id
    json.label                  modification_part.part.label
    json.manufacturer_reference modification_part.part.manufacturer_reference
  end
else
  json.part nil
end
