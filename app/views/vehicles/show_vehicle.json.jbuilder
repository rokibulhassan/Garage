# NOTE: I don't use partial due to hard debugging.
# (see https://github.com/rails/jbuilder/issues/40).
#
# This template is used to seed data on the show vehicle page.
# It exposes the attributes of the vehicle.
json.extract! vehicle, :id

json.attributes vehicle.vehicle_attributes do |json, attribute|
  field_definition = attribute.field_definition
  json.name field_definition.name

  case field_definition.type
  when 'FieldDefinition::DynamicChoice'
    json.value attribute.dynamic_value.name
    json.label attribute.dynamic_value.label

  when 'FieldDefinition::StaticChoice'
    json.value attribute.static_value.name
    json.label attribute.static_value.label

  when 'FieldDefinition::NumericInteger'
    json.value attribute.value

  when 'FieldDefinition::NumericDecimalWithUnit'
    json.value     attribute.value
    json.unit      attribute.unit.name
    json.unitLabel attribute.unit.label
  end
end

