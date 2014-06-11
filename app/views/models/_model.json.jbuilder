json.id             model.id
json.name           model.name
json.type           model.vehicle_type
json.pending        model.pending
json.rejected       model.rejected
json.upvotesCount   model.upvotes_count
json.downvotesCount model.downvotes_count

json.brand do |json|
  json.id model.brand_id
end
