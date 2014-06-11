json.id part_purchase.id
json.main part_purchase.main

json.part do |json|
  json.id                     part_purchase.part.id
  json.label                  part_purchase.part.label
  json.manufacturer_reference part_purchase.part.manufacturer_reference
end

if part_purchase.vendor_id?
  json.vendor do |json|
    json.id           part_purchase.vendor.id
    json.name         part_purchase.vendor.name
    json.country_code part_purchase.vendor.country_code
  end
else
  json.vendor nil
end

json.special  part_purchase.special?
json.price    part_purchase.price
json.quantity part_purchase.quantity
json.bought_at part_purchase.bought_at
