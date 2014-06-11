class Models.PrewrittenVersionCommentWithUser extends Backbone.RelationalModel
  url: '/api/versions/prewritten_comments'
  # send post request
  isNew: -> true
