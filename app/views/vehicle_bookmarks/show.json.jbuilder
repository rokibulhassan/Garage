json.vehicle do |json|
  json_partial!(json, 'vehicles/vehicle', vehicle: @vehicle)
end
