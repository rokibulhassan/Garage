json.array! @versions do |json, version|
  json_partial!(json, 'versions/version', version: version)
end
