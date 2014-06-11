json.array! @countries do |json, country|
  name, code = country
  country = Country[code]

  json.code  country.alpha2
  json.label country.name
end
