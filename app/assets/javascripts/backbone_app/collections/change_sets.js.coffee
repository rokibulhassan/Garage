class Collections.ChangeSets extends Backbone.Collection
  model: Models.ChangeSet

  url: ->
    "/api/vehicles/#{@vehicle.id}/change_sets"
