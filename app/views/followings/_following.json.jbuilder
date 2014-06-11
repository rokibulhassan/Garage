json.id         following.id
json.thing do |json|
  json.id   following.thing_id
  json.type following.thing_type
end

json.user do |json|
  json.id following.user_id
end


