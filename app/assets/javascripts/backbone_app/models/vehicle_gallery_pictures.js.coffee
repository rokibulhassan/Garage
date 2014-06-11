class Models.VehicleGalleryPicture extends Models.Picture
  galleryTitle: () ->
    ''
  user: () ->
    @get('vehicle').get('user')
