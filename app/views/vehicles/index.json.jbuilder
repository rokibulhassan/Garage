json.array! @vehicles do |json, vehicle|
  json.partial!('vehicles/vehicle', vehicle: vehicle)
end
