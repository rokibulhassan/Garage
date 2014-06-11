class Collections.VehicleGalleryPictures extends Backbone.Collection
  model: Models.VehicleGalleryPicture

  url: ->
    "/vehicles/#{@vehicle.get('id')}/galleries/pictures"

  comparator: (model) ->
    model.get('position')
