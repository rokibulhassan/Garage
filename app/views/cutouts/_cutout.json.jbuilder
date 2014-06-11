json.id     cutout.id
json.url    cutout.media_content_url
json.type   cutout.media_type
json.layout cutout.layout
json.row    cutout.row
json.col    cutout.col
json.width  cutout.dimensions[:w]
json.height cutout.dimensions[:h]

unless cutout.new_record? || cutout.picture.blank?
  json.picture do |json|
    json.id cutout.picture_id

    if cutout.collage.type == 'ProfileCollage'
      json.title   cutout.picture.title
      json.gallery do |json|
        json.id      cutout.picture.gallery.id
        json.vehicle do |json|
          json.id cutout.picture.gallery.vehicle_id
        end
      end
    end
  end
end
