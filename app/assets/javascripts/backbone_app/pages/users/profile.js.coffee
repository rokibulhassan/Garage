# This page display the public profile of an user.
class Pages.Users.Profile extends Backbone.Marionette.Layout
  template: 'pages/users/profile'

  regions:
    breadcrumb:  '#breadcrumb'
    collages:    '#collages'
    vehicles:    '#vehicles'
    comparisons: '#comparisons'
    follow:      '#follow'

  events:
    'click ul.nav-tabs li > a' : 'tabClicked'
    'click .add-opposer'       : 'addToUserOpposers'
    'click .edit-collages'     : 'editCollages'
    'click .edit-collages-out' : 'editCollagesOut'
    'click .silhouettes-bar-link' : 'showVehicle'
    'click .bubble-comment-avatar-img' : 'goToUserProfilePage'
    'click .bubble-comment-amt-comments-link' : 'goToCommentsPage'

  editCollages   : Views.Mixins.editCollages
  editCollagesOut: Views.Mixins.editCollagesOut
  renderCollages : Views.Mixins.renderCollages

  initialize: ({@activeTab, @comparisonTables, @vehicleType})->
    @activeTab ||= 'wall'
    @collageMode = 'collages_list'
    @currentUser = Store.get('currentUser')

  onRender: ->
    @model.get('collages').fetch success: (collection, response)=>
      @renderCollages collection, @collages
      if @activeTab?
        callback = =>
          if @activeTab is 'wall' and !@canShowWall()
            @activeTab = 'vehicles'
          @$('.nav-tabs a[data-target="#' + @activeTab + '"]').tab('show')
        setTimeout(callback, 0)

    @vehicles.show new Fragments.Users.Profile.Vehicles
      user:       @model
      collection: @model.get('vehicles')

    if @currentUser?
      @currentUser.get('followings').fetch success: (followings)=>
        @follow.show new Fragments.Users.Profile.Follow model: @model, followings: followings

    unless @canManage()
      @comparisons.show new Pages.Users.ComparisonTables comparisonTables: @comparisonTables, user: @model

    @$('.bubble-comment-avatar').popover('show')

    @renderBreadcrumbs()

  canShowWall: ->
    $('#wall li').length isnt 0

  renderBreadcrumbs: ->
    @breadcrumb.show new Fragments.Breadcrumb.Index
      collection: Collections.Breadcrumbs.forProfile(@model, @activeTab, @vehicleType)

  tabClicked: (event) ->
    target = $(event.target)
    if target.data('target')?
      @activeTab = target.data('target').substr(1)
      @renderBreadcrumbs()
    if @activeTab is 'comparisons'
      Backbone.history.navigate Routers.Main.showUserProfileComparisonsPath(@model)
    else if @activeTab is 'vehicles'
      Backbone.history.navigate Routers.Main.showUserProfileVehiclesPath(@model)
    else if @activeTab is 'wall'
      Backbone.history.navigate Routers.Main.showUserProfilePath(@model)
    target.tab('show')
    false

  showVehicle: (e) ->
    vehicle_id = $(e.target).data 'id'
    vehiclePath = Routers.Main.showUserVehiclePath @model, @model.get('vehicles').get vehicle_id
    Backbone.history.navigate(vehiclePath, true)
    false

  canManage: ->
    Models.Ability.canManageUser(@model)

  addToUserOpposers: ->
    bootbox.confirm(
      "Are you sure to block <strong>#{@model.get('username')}</strong> permanently?",
      (submit) =>
        if submit
          userOpposition = new Models.UserOpposition
          userOppositionAttrs =
            opposer_id: @model.id
          userOpposition.save userOppositionAttrs,
            wait: true
    )
    false

  goToUserProfilePage: (e) ->
    $target = $(e.currentTarget).closest('a').first()
    userId = $target.data('user-id')
    return false unless userId
    userProfilePath = Routers.Main.showUserProfilePath(userId)
    Backbone.history.navigate(userProfilePath, true)
    false

  goToCommentsPage: (e) ->
    vehicleId = $(e.currentTarget).data('vehicle-id')
    path = Routers.Main.showVehicleCommentsPath(vehicleId)
    Backbone.history.navigate(path, true)
    false

  amountVehiclesSilhouettes: ->
    totalWidth = @silhouettesBarWidth()
    vehicles = _.clone(@model.get('vehicles').models).reverse()
    amt = width = 0
    for v in vehicles
      width += v.sideViewWidth()
      width += 20 # margin-right
      if width >= totalWidth
        return amt - 1
      else
        amt++
    amt

  # width in px
  silhouettesBarWidth: ->
    if @canManage()
      752
    else
      658

  serializeData: ->
    user:                      @model
    canManage:                 @canManage()
    canAddToOpposers:          Models.Ability.canAddToOpposers(@model.get('username'))
    amountVehiclesSilhouettes: @amountVehiclesSilhouettes()
