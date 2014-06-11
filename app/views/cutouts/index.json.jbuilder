json.array! @cutouts do |json, cutout|
  json.partial!('cutouts/cutout', cutout: cutout)
end
