json.array! @categories do |json, category|
  json.name  category.name
  json.label category.label

  json.availableItems category.field_definitions do |json, item|
    json.name  item.name
    json.label item.label
    json.type  item.type.demodulize.camelcase(:lower).underscore

    case item.type
    when 'FieldDefinition::StaticChoice'
      json.values item.static_values do |json, value|
        json.name  value.name
        json.label value.label
      end
    when 'FieldDefinition::NumericDecimalWithUnit'
      json.unitType item.unit_type.name
    end
  end
end
