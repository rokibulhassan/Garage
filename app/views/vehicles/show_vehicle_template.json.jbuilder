# The fieldsets with these attributes.

# This template is used to seed data on the show vehicle page.
# It exposes the way fieldsets are displayed.

json.array! fieldsets do |json, fieldset_with_fields|
  fieldset, fields = fieldset_with_fields

  json.extract! fieldset, :name, :label

  json.attributes fields do |json, field|
    json.extract! field, :name, :label
    json.type field.type.demodulize.camelcase(:lower)
  end
end
