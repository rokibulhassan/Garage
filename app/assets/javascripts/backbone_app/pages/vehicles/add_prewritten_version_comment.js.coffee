class Fragments.Vehicles.AddPrewrittenVersionComment extends Backbone.Marionette.ItemView
  template: 'fragments/vehicles/add_prewritten_version_comment'

  events:
    'change .version-add-prewritten-comment-select' : 'addCommentToVersion'

  initialize: ({@prewrittenComments, @currentUser}) ->
    @version = @model

  addCommentToVersion: (e) ->
    $target = $(e.currentTarget)
    commentId = parseInt($target.val(), 10)
    commentAssoc = new Models.PrewrittenVersionCommentWithUser
      version_id: @version.id
      user_id: @currentUser.id
      prewritten_comment_id: commentId
    commentAssoc.save().then =>
      newVersionComment = if isNaN(commentId) then null else @prewrittenComments.get(commentId)
      @version.set 'current_user_comment', newVersionComment?.attributes
      @render()

  onRender: ->
    _.defer => @$('select').chosen()

  commentsForVersion: ->
    @prewrittenComments.filter (comment) =>
      comment.get('vehicle_type') is @version.get('vehicle_type')

  serializeData: ->
    currentCommentOnVersionByUser: @version.get('current_user_comment')
    comments: @commentsForVersion()
