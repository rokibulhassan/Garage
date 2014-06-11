json.array! @comparison_table_vehicles do |json, comparison_table_vehicle|
  vehicle  = comparison_table_vehicle.vehicle
  revision = comparison_table_vehicle.revision

  json.id comparison_table_vehicle.id

  if revision
    json.revision do |json|
      json.id    revision.id
      json.label revision.label
      json.propertyInstances revision.property_instances do |json, property_instance|
        json_partial! json, 'property_instances/property_instance', property_instance: property_instance
      end
    end
  else
    json.revision nil
  end

  json.vehicle do |json|
    json.id vehicle.id

    json.version do |json|
      json.id           vehicle.version.id
      json.name         vehicle.version.name
      json.label        vehicle.version.label

      json.propertyInstances vehicle.version.property_instances do |json, property_instance|
        json_partial! json, 'property_instances/property_instance', property_instance: property_instance
      end
    end

    json.revisions vehicle.revisions do |json, revision|
      json.id    revision.id
      json.label revision.label
      json.propertyInstances revision.property_instances do |json, property_instance|
        json_partial! json, 'property_instances/property_instance', property_instance: property_instance
      end
    end
  end
end
