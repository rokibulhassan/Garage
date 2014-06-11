Collections.Comments = Backbone.Collection.extend
  model: Models.Comment

  url: ->
    "/api/pictures/#{@picture.id}/comments"
