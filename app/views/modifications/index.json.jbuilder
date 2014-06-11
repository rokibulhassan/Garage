json.array! @modifications do |json, modification|
  json_partial!(json, 'modifications/modification', modification: modification)
end
