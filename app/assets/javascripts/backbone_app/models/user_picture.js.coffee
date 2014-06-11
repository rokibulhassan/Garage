//= require ./picture
Models.UserPicture = Models.Picture.extend
  galleryTitle: ->
    "#{@get('user').get('username')}'s pictures"
