json.array! @generations do |json, generation|
  json_partial! json, 'generation', generation: generation
end