json.array! @systems do |json, system|
  json_partial!(json, '/units_systems/units_system', system: system)
end
