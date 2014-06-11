class Collections.Collages extends Backbone.Collection
  model: Models.Collage

  url: ->
    "/api/galleries/#{@gallery.id}/collages"
