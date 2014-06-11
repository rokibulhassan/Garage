class Routers.Main extends Backbone.Marionette.AppRouter
  controller: Controllers.Main

  appRoutes:
    ''                            : 'home'
    'dashboard'                   : 'dashboard'

    'my/favorites'                : 'myFavorites'
    'my/dashboard'                : 'myDashboard'
    'my/bookmarks'                : 'myBookmarks'
    'my/vehicles'                 : 'myProfile'
    'my/vehicles/cars'            : 'myProfileCars'
    'my/vehicles/bikes'           : 'myProfileBikes'
    'my/vehicles/vehicles'        : 'myProfileVehicles'
    'my/profile/edit'             : 'editMyProfile'
    'my/profile/edit/:tab'        : 'editMyProfile'
    'my/people'                   : 'myPeople'
    'my/people/:tab'              : 'myPeople'
    'my/comparison_tables'        : 'showMyComparisons'
    'my/comparison_tables/:id'    : 'showMyComparison'

    'vehicles/new'                : 'newVehicle'
    'vehicles/search'             : 'searchVehicles'
    'vehicles/cars/search'        : 'searchVehiclesCars'
    'vehicles/bikes/search'       : 'searchVehiclesBikes'

    'users/:user_id/vehicles/:id' : 'showUserVehicle'
    'users/:user_id'              : 'showUserProfile'
    'users/:user_id/vehicles'     : 'showUserProfileVehicles'
    'users/:user_id/cars'         : 'showUserProfileCars'
    'users/:user_id/bikes'        : 'showUserProfileBikes'
    'users/:user_id/albums'       : 'showUserAlbums'
    'users/:user_id/comparison_tables'     : 'showUserProfileComparisons'
    'users/:user_id/comparison_tables/:id' : 'showUserComparison'

    'profiles/:user_id/pictures/new?:querystring' : 'newProfilePicture'
    'vehicles/:vehicle_id/galleries/:id'          : 'showGallery'
    'vehicles/:vehicle_id/comments'               : 'showVehicleComments'

    'vehicles/:vehicle_id/specifications' : 'showSpecificationsTab'
    'vehicles/:vehicle_id/performances'   : 'showPerformancesTab'
    'vehicles/:vehicle_id/modifications'  : 'showModificationsTab'
    'vehicles/:vehicle_id/identification/edit' : 'showIdentificationEditTab'
    'vehicles/:vehicle_id/identification' : 'showIdentificationTab'

    'comparison_tables/recent'             : 'showRecentComparisons'
    'albums'                               : 'showAlbums'
    'albums/:id'                           : 'showAlbum'
    'myy_cloud'                            : 'showMyyCloud'
    'myy_cloud/:tab'                       : 'showMyyCloud'

  @rootPath: ->
    '/'

  @albumsPath: ->
    '/albums'

  @myDashboardPath: ->
    'my/dashboard'

  @showUserProfilePath: (userOrId)->
    if userOrId.isNew && userOrId.isNew()
      return

    id = if typeof userOrId is 'number'
      userOrId
    else
      userOrId.id

    currentUser = Store.get('currentUser')
    if currentUser and currentUser.id is id
      '/my/vehicles'
    else
      "/users/#{id}"

  @showVehicleCommentsPath: (vehicleOrId) ->
    "/vehicles/#{@extractId(vehicleOrId)}/comments"

  @showUserProfileVehiclesPath: (user)->
    Routers.Main.showUserProfilePath(user) + '/vehicles'

  @showUserVehiclePath: (user, vehicle)->
    "users/#{@extractId(user)}/vehicles/#{@extractId(vehicle)}"

  @myyCloudPath: (tab)->
    if tab?
      "myy_cloud/#{tab}"
    else
      'myy_cloud'

  @showMyPeoplePath: ->
    "my/people"

  @showMyCarsPath: ->
    'my/vehicles/cars'

  @showMyBikesPath: ->
    'my/vehicles/bikes'

  @showVehicleGalleryPath: (gallery)->
    # another bug of Backbone-Relational
    vehicleId = if gallery instanceof Models.Gallery then gallery.get('vehicle').id else gallery.vehicle.id
    "/vehicles/#{vehicleId}/galleries/#{gallery.id}"

  @showVehiclePath: (vehicle)->
    "/vehicles/#{@extractId(vehicle)}"

  @showVehicleIdentificationPath: (vehicle) ->
    "/vehicles/#{@extractId(vehicle)}/identification"

  @showVehicleIdentificationEditPath: (vehicle) ->
    "/vehicles/#{@extractId(vehicle)}/identification/edit"

  @showMyComparisonsPath: ->
    "my/comparison_tables"

  @showMyComparisonPath: (comparison) ->
    "my/comparison_tables/#{@extractId(comparison)}"

  @showUserProfileComparisonsPath: (user) ->
    "/users/#{@extractId(user)}/comparison_tables"

  @showUserComparisonPath: (user, comparison) ->
    "/users/#{@extractId(user)}/comparison_tables/#{@extractId(comparison)}"

  @showRecentComparisonsPath: ->
    'comparison_tables/recent'

  @editMyProfilePath: (tab)->
    if tab?
      "my/profile/edit/#{tab}"
    else
      'my/profile/edit'

  @showMyPeopleFollowingsPath: ->
    '/my/people/followings'

  @showMyPeopLeFollowersPath: ->
    '/my/people/followers'

  @showMyPeopleBlockedPath: ->
    '/my/people/blocked'

  @showAlbumPath: (album)->
    "/albums/#{@extractId(album)}"

  @showUserAlbumsPath: (user)->
    "/users/#{@extractId(user)}/albums"

  @extractId: (modelOrId) ->
    if typeof modelOrId is 'number'
      modelOrId
    else
      modelOrId.id
