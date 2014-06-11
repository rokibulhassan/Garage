class Collections.Services extends Backbone.Collection
  model: Models.Service

  url: ->
    "/api/vehicles/#{@modification.get('vehicle').id}/modifications/#{@modification.id}/services"
