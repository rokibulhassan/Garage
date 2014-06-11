Collections.Pictures = Backbone.Collection.extend
  model: Models.Picture

  url: ->
    "/api/galleries/#{@gallery.id}/pictures"

  comparator: (model)->
    model.get('position')
