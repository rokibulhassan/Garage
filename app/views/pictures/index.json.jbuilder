json.array! @pictures do |json, picture|
  json.partial!('pictures/picture', picture: picture)
end
