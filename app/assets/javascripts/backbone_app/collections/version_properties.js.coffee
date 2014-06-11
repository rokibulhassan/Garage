class Collections.VersionProperties extends Backbone.Collection
  model: Models.VersionProperty

  url: ->
    "/api/versions/#{@version.id}/properties"
