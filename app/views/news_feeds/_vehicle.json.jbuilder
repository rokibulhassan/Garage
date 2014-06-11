json.id     vehicle.id
json.userId vehicle.user_id

json.label  vehicle.label
json.type   vehicle.vehicle_type
json.keywords vehicle.keywords

json.year       vehicle.year
json.approved   vehicle.version.try(:approved?)

json.brand do |json|
  json_partial!(json, 'brands/brand', brand: BrandDecorator.new(vehicle.brand))
end

json.model do |json|
  json_partial!(json, 'models/model', model: ModelDecorator.new(vehicle.model.model))
end

json.version do |json|
  json_partial!(json, 'versions/version', version: vehicle.version)
end

json.side_view do |json|
  json_partial!(json, 'side_views/side_view', side_view: vehicle.side_view || SideView.new)
end
