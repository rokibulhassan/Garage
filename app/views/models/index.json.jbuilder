json.array! @models do |json, model|
  json.partial! 'models/model', model: model
end
