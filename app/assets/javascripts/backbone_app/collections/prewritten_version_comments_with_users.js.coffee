class Collections.PrewrittenVersionCommentsWithUsers extends Backbone.Collection
  model: Models.PrewrittenVersionCommentWithUser

  url: ->
    "/api/versions/#{@version.id}/comments"
