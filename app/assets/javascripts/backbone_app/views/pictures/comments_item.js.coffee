Fragments.Pictures.CommentsItem = Backbone.Marionette.ItemView.extend
  template: 'fragments/pictures/comments_item'
  tagName:   'li'

  events:
    'click .edit-comment'   : 'showPictureCommentInput'
    'blur .comment-input'   : 'hidePictureCommentInput'
    'keydown .comment-input': 'submitPictureComment'
    'click .delete-comment' : 'deletePictureComment'
    'click .add-opposer'    : 'addToUserOpposers'
    'click .show-user'      : 'goToUserProfile'

  initialize: ->
    @bindTo @model, 'change:body', @render

  showPictureCommentInput: ->
    @$('.picture-comment').hide()
    @$('.comment-input').show().focus()

  hidePictureCommentInput: ->
    @$('.picture-comment').show()
    @$('.comment-input').hide()

  submitPictureComment: (event)->
    event.stopPropagation()
    if event.which == 13
      @updatePictureComment()
      event.preventDefault()

  updatePictureComment: ->
    @model.save { body: @$('.comment-input').val() },
      wait: true

    @hidePictureCommentInput()

  deletePictureComment: ->
    @model.destroy
      wait: true

  addToUserOpposers: ->
    bootbox.confirm(
      "Are you sure to block <strong>#{@model.get('user').get('username')}</strong> permanently?",
      (submit)=>
        if submit
          userOpposition = new Models.UserOpposition
          userOppositionAttrs =
            opposer_id: @model.get('user').id
          userOpposition.save userOppositionAttrs,
            wait: true
            success: =>
              @model.collection.fetch()
    )
    false

  goToUserProfile: ->
    Backbone.history.navigate(Routers.Main.showUserProfilePath(@model.get('user')), true)
    MyApp.modal.currentView.close()
    false

  serializeData: ->
    comment:   @model
    commentUserPath:  Routers.Main.showUserProfilePath(@model.get('user'))
    canManage: Models.Ability.canManageComment(@model)
    canAddToOpposers: Models.Ability.canAddToOpposers(@model.get('user').get('username'))
    canManageVehicle: Models.Ability.canManagePicture(@model.get('picture'))
