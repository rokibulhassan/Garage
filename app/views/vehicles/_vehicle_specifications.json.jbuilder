fieldsets_with_specifications = vehicle.vehicle_attributes.group_by { |s| s.field_definition.fieldset }

json.specifications fieldsets_with_specifications do |json, fieldset_with_specifications|
  fieldset, specifications = fieldset_with_specifications

  json.name     fieldset.name
  json.label    fieldset.label

  json.items specifications do |json, specification|
    field_definition = specification.field_definition

    json.type     field_definition.type.demodulize.camelcase(:lower).underscore
    json.name     field_definition.name
    json.label    field_definition.label

    case field_definition.type
    when 'FieldDefinition::NumericInteger'
      json.value specification.value.to_f

    when 'FieldDefinition::DynamicChoice'
      json.value do |json|
        json.name  specification.dynamic_value.name
        json.label specification.dynamic_value.label
      end

    when 'FieldDefinition::NumericDecimalWithUnit'
      json.value specification.value.to_f
      json.unit do |json|
        json.type  specification.unit.unit_type.name
        json.name  specification.unit.name
        json.label specification.unit.label
      end

    when 'FieldDefinition::StaticChoice'
      json.value do |json|
        json.name  specification.static_value.name
        json.label specification.static_value.label
      end
    end
  end
end
