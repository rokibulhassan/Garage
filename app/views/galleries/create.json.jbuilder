json.array!([ @picture ]) do |json, picture|
  json.name          picture.image_file_name
  json.size          picture.image_file_size
  json.url           public_image_url(picture.image.url)
  json.thumbnail_url public_image_url(picture.image.url(:thumbnail))
  json.delete_url    user_gallery_picture_url(current_user, @gallery, picture)
  json.delete_type   'DELETE'
end
