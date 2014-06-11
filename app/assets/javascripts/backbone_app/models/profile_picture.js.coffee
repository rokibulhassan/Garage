class Models.ProfilePicture extends Models.Picture
  user: ->
    @get('profile')

  galleryTitle: ->
    "#{@user().get('username')}'s imported pictures"
