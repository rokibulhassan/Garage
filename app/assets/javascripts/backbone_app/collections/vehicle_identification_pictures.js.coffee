class Collections.VehicleIdentificationPictures extends Backbone.Collection
  model: Models.VehicleIdentificationPicture

  url: ->
    "/vehicles/#{@vehicle.get('id')}/pictures"

  comparator: (model) ->
    model.get('position')
