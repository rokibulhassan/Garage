json.array! @corrections do |json, correction|
  json.partial!('correction', correction: correction)
end
