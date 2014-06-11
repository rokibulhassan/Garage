class Collections.Galleries extends Backbone.Collection
  model: Models.Gallery

  url: ->
    "/vehicles/#{@vehicle.id}/galleries"
