json.id id
properties.each do |name, property|
  json.set! name do |json|
    json.partial! 'version_properties/version_property', property: property
  end
end