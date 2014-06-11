class Collections.SideViews extends Backbone.Collection
  model: Models.SideView

  url: ->
    "/api/side_views"