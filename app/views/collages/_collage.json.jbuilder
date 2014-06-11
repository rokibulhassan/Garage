json.id            collage.id
json.active_layout collage.active_layout

if collage.type == 'GalleryCollage'
  json.gallery do |json|
    json.id collage.gallery_id
  end
end

json.cutouts do |json|
  json.array! collage.cutouts_of_active_layout do |json, cutout|
    json.partial!('cutouts/cutout', cutout: cutout)
  end
end
