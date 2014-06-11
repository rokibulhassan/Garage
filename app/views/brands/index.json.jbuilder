json.array! @brands do |json, brand|
  json.partial!('brands/brand', brand: brand)
end
