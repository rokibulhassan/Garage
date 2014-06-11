json.id          vendor.id
json.name        vendor.name
json.website     vendor.website
json.street      vendor.street
json.zipcode     vendor.zipcode
json.city        vendor.city

if vendor.country_code
  json.country do |json|
    country = Country[vendor.country_code]

    json.code  country.alpha2
    json.label country.name
  end
end
