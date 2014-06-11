class Collections.Followings extends Backbone.Collection
  model: Models.Following

  url: ->
    "/api/followings"
