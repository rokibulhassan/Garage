class Collections.Cutouts extends Backbone.Collection
  model: Models.Cutout

  url: ->
    "/api/collages/#{@collage.id}/cutouts"
