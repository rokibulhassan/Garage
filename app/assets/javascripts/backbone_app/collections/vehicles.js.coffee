class Collections.Vehicles extends Backbone.Collection
  model: Models.Vehicle

  url: ->
    '/api/vehicles'
