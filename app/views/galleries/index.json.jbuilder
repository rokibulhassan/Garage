json.array! @galleries do |json, gallery|
  json.partial! 'gallery', gallery: gallery
end
