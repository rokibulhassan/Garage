json.array! @pictures do |json, picture|
  json.partial!('galleries/pictures/picture', picture: picture)
end
