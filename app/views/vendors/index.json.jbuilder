json.array! @vendors do |json, vendor|
  json_partial! json, 'vendor', vendor: vendor
end
