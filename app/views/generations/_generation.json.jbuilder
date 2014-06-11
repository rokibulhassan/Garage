json.id          generation.id
json.number      generation.number
json.started_at  generation.started_at
json.finished_at generation.finished_at
json.version do |json|
  json.id generation.version_id
end