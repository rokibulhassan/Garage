class Collections.Modifications extends Backbone.Collection
  model: Models.Modification

  url: ->
    "/api/vehicles/#{@vehicle.id}/modifications"
