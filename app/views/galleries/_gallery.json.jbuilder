json.id                 gallery.id
json.title              gallery.title
json.position           gallery.position
json.cover_picture_url  gallery.cover_picture_url
json.cover_picture_alt  gallery.cover_picture_alt
json.layout             gallery.layout
json.privacy            gallery.privacy if can? :manage, gallery
