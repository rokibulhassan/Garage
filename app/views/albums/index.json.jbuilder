json.array! @albums do |json, album|
  json.partial!('album', album: album)
end
