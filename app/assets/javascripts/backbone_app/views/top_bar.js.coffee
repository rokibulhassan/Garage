class Views.TopBar extends Backbone.Marionette.Layout
  template: 'top_bar'

  events:
    'click .all-news'              : 'goToAllNews'
    'click .my-news'               : 'goToMyNews'
    'click .bookmarks'             : 'goToMyBookmarks'
    'click .users-vehicles'        : 'goToVehiclesSearch'
    'click .users-cars'            : 'goToVehiclesSearchCars'
    'click .users-bikes'           : 'goToVehiclesSearchBikes'
    'click .albums'                : 'goToAlbums'
    'click .my-profile'            : 'goToMyProfile'
    'click .my-cars'               : 'goToMyCars'
    'click .my-bikes'              : 'goToMyBikes'
    'click .my-comparisons'        : 'goToMyComparisons'
    'click .recent-comparisons'    : 'goToRecentComparisons'
    'click .imported-content'      : 'goToImportedContent'
    'click .my-public-albums'      : 'goToMyPublicAlbums'
    'click .my-private-albums'     : 'goToMyPrivateAlbums'
    'click .edit-my-profile'       : 'goToEditMyProfile'
    'click .followings'            : 'goToFollowings'
    'click .followers'             : 'goToFollowers'
    'click .blocked'               : 'goToBlocked'
    'click .sign-out'              : 'signOut'
    'click .signup'                : 'signup'
    'click .dropdown-menu a'       : 'hideDropDown'
    'click .inactive .unit-system-change-link' : 'switchUnitSystem'


  initialize: ->
    @currentUser = Store.get('currentUser')
    @unreadMessages = unreadMessages
    unless @currentUser?
      @bindTo MyApp.vent, 'user:created', =>
        @currentUser = Store.get('currentUser')
        @render()

  onRender: ->
    setTimeout( =>
      @$('.chosen').chosen()
    , 0)

  goToAllNews: ->
    Backbone.history.navigate '/dashboard', true
    false

  goToMyNews: ->
    Backbone.history.navigate '/my/dashboard', true
    false

  goToMyBookmarks: ->
    if @currentUser?
      Backbone.history.navigate '/my/bookmarks', true

    false

  goToVehiclesSearch: ->
    Backbone.history.navigate '/vehicles/search', true
    false

  goToVehiclesSearchCars: ->
    Backbone.history.navigate '/vehicles/cars/search', true
    false

  goToVehiclesSearchBikes: ->
    Backbone.history.navigate '/vehicles/bikes/search', true
    false

  goToAlbums: ->
    Backbone.history.navigate Routers.Main.albumsPath(), true
    false

  goToImportedContent: ->
    Backbone.history.navigate Routers.Main.myyCloudPath('imported_content'), true
    false

  goToMyPublicAlbums: ->
    Backbone.history.navigate Routers.Main.myyCloudPath('public_galleries'), true
    false

  goToMyPrivateAlbums: ->
    Backbone.history.navigate Routers.Main.myyCloudPath('private_galleries'), true
    false

  goToMyProfile: ->
    if @currentUser?
      Backbone.history.navigate Routers.Main.showUserProfilePath(@currentUser), true
    false

  goToMyCars: ->
    if @currentUser?
      Backbone.history.navigate Routers.Main.showMyCarsPath(), true
    false

  goToMyBikes: ->
    if @currentUser?
      Backbone.history.navigate Routers.Main.showMyBikesPath(), true
    false


  goToEditMyProfile: ->
    if @currentUser?
      Backbone.history.navigate 'my/profile/edit', true

    false

  goToFollowings: ->
    Backbone.history.navigate Routers.Main.showMyPeopleFollowingsPath(), true
    false

  goToFollowers: ->
    Backbone.history.navigate Routers.Main.showMyPeopLeFollowersPath(), true
    false

  goToBlocked: ->
    Backbone.history.navigate Routers.Main.showMyPeopleBlockedPath(), true
    false

  goToMyComparisons: ->
    if @currentUser?
      Backbone.history.navigate Routers.Main.showMyComparisonsPath(), true
    false

  goToRecentComparisons: ->
    Backbone.history.navigate Routers.Main.showRecentComparisonsPath(), true
    false

  hideDropDown: (e)->
    $(e.target).parents('.dropdown').removeClass('open')
    false

  signOut: ->
    if @currentUser?
      bootbox.confirm "Are you sure?",
        (submit)=>
          if submit
            $.ajax(type: 'DELETE', url:  '/sign_out')
              .done =>
                Store.set 'currentUser', null
                window.location.replace '/'

    false

  signup: ->
    Backbone.history.navigate 'signup'
    MyApp.modal.show new Modals.Users.New

    false

  switchUnitSystem: (e) ->
    return unless @currentUser
    oldSys = @currentUser.get('system_of_units_code')
    newSys = $(e.currentTarget).data('unit-system')
    return false if oldSys == newSys
    @currentUser.set('system_of_units_code', newSys)
    promise = @currentUser.save({}, wait: true)
    promise.done ->
      location.reload(true)

  serializeData: ->
    currentUser: @currentUser
    unreadMessages: @unreadMessages

