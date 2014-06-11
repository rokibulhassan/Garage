class Collections.ModificationProperties extends Backbone.Collection
  model: Models.ModificationProperty

  url: ->
    "/api/modifications/#{@modification.id}/properties"
