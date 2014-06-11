json.array! @pictures do |json, picture|
  json.partial! 'picture', picture: picture
end