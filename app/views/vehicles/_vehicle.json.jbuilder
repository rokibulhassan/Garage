# The complete version of a vehicle. This object is an heavy one so take
# care of eager loading.
# The goal is to keep it for a while, giving it everything so it
# doesn't have to be reloaded.

json.id     vehicle.id
json.userId vehicle.user_id


json.label  vehicle.label
json.type   vehicle.vehicle_type
json.keywords vehicle.keywords

json.year       vehicle.year
json.approved   vehicle.version.approved?

json_partial!(json, 'vehicles/vehicle_avatars', vehicle: vehicle)

# associations

json.user do |json|
  json.id vehicle.user_id
end

json.brand do |json|
  json_partial!(json, 'brands/brand', brand: BrandDecorator.new(vehicle.brand))
end

json.model do |json|
  json_partial!(json, 'models/model', model: ModelDecorator.new(vehicle.model.model))
end

json.version do |json|
  json_partial!(json, 'versions/version', version: vehicle.version)
end

json.ownership do |json|
  json.id vehicle.ownership.id
end

json.side_view do |json|
  json_partial!(json, 'side_views/side_view', side_view: vehicle.side_view || SideView.new)
end

# TODO: don't send this on every request, only on Identification tab
json.collage do |json|
  json_partial!(json, 'collages/collage', collage: vehicle.default_collage)
end

json.part_purchases vehicle.part_purchases do |json, part_purchase|
  json_partial!(json, 'part_purchases/part_purchase', part_purchase: part_purchase)
end
