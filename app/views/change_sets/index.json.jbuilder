json.array! @change_sets do |json, change_set|
  json.partial! 'change_set', change_set: change_set
end
