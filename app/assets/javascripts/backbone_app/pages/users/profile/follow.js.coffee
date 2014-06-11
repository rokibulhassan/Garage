class Fragments.Users.Profile.Follow extends Backbone.Marionette.ItemView
  template: 'fragments/users/profile/follow'

  events:
    'click .follow'   : 'follow'
    'click .unfollow' : 'unfollow'

  initialize: ({@followings})->

  follow: ->
    following = new Models.Following
    following.collection = @followings
    following.save {thing_id: @model.id, thing_type: 'User'},
      success: (model)=>
        @followings.add model
        @render()
    return false

  unfollow: ->
    f = @followings.find (following) => following.isFollow(@model)
    return false unless f
    promise = f.destroy()
    promise.then =>
      @render()
    false

  serializeData: ->
    canFollow: Models.Ability.canFollow(@model)
    canManage: Models.Ability.canManageUser(@model)
