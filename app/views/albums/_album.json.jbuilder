json.id                 album.id
json.title              album.title
json.cover_picture_url  album.cover_picture_url
json.cover_picture_alt  album.cover_picture_alt
json.privacy            album.privacy if can? :manage, album

json.user do |json|
  json.id album.user_id
  json.username album.user.username
end
