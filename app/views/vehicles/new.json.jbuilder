# Render all the templates.
# Each template is just a group of fieldsets.
index = 0
json.array! @fields_by_type.keys do |json, vehicle_type|
  index += 1

  json.id   index
  json.type vehicle_type

  json.fieldsets do |json|
    json.partial!(
      'fieldsets',
      fields_by_fieldset: @fields_by_type[vehicle_type]
    )
  end
end
