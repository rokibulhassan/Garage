json.array! @vehicles do |json, vehicle|
  json.partial!('data_sheets/data_sheet', properties: vehicle.version.data_sheet_props, id: vehicle.id)
  json.vehicle do |json|
    json.partial!('vehicles/vehicle', vehicle: VehicleDecorator.new(vehicle))
  end
end

