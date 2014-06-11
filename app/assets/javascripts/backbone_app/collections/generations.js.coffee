class Collections.Generations extends Backbone.Collection
  model: Models.Generation

  url: ->
    "/api/versions/#{@version.id}/generations"
