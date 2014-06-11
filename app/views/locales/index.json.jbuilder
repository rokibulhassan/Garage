json.array! @locales do |json, locale|
  code, label = locale
  json.code  code
  json.label label
end
