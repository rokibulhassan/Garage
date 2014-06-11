class Models.VehicleIdentificationPicture extends Models.Picture
  user: ->
    @get('vehicle').get('user')
  galleryTitle: ->
    ''
