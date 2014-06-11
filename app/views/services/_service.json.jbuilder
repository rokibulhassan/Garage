json.id            service.id
json.service_type  service.service_type
json.duration_type service.duration_type

if service.vendor_id
  json.vendor do |json|
    json_partial! json, 'vendors/vendor', vendor: service.vendor
  end
end

