json.array! @revisions do |json, revision|
  json.id   revision.id
  json.date revision.date

  json.modifications revision.modifications do |json, modification|
    json.id   modification.id
    json.name modification.name
  end
end
