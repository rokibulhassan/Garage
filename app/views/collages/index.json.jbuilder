json.array! @collages do |json, collage|
  json.partial!('collages/collage', collage: collage)
end
