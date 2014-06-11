class Collections.Breadcrumbs extends Backbone.Collection
  model: Models.Breadcrumb

  showGalleries: ->
    showGalleriesBreadcrumb = _.find @models, (breadcrumb)=>
      breadcrumb.get('text') == I18n.t('galleries', scope: 'breadcrumb')
    showGalleriesBreadcrumb?.get('callback')?.call()

  @forVehicle: (vehicle, currentTab = null) ->
    types = { automobile: 'cars', motorcycle: 'bikes' }
    breadcrumbs = new Collections.Breadcrumbs

    currentUser = Store.get('currentUser')
    userProfilePath = Routers.Main.showUserProfilePath(vehicle.get('user'))
    userProfileVehiclesPath = Routers.Main.showUserProfileVehiclesPath(vehicle.get('user'))

    type  = types[vehicle.get 'type']

    if currentUser? and currentUser.id == vehicle.get('user').id
      breadcrumbs.add new Models.Breadcrumb
        text: I18n.t('myy_garage', scope: 'breadcrumb')
        callback: => Backbone.history.navigate userProfileVehiclesPath, true
      breadcrumbs.add new Models.Breadcrumb
        text: I18n.t("myy_#{type}", scope: 'breadcrumb')
        callback: => Backbone.history.navigate "#{userProfilePath}/#{type}", true
    else
      breadcrumbs.add new Models.Breadcrumb
        text: "#{vehicle.get('user').get('username')}"
        callback: => Backbone.history.navigate userProfilePath, true
      breadcrumbs.add new Models.Breadcrumb
        text: I18n.t('garage', scope: 'breadcrumb')
        callback: => Backbone.history.navigate userProfileVehiclesPath, true
      breadcrumbs.add new Models.Breadcrumb
        text: I18n.t(type, scope: 'breadcrumb')
        callback: => Backbone.history.navigate "#{userProfilePath}/#{type}", true

    breadcrumbs.add new Models.Breadcrumb
      text: vehicle.longLabel()
      callback: => Backbone.history.navigate Routers.Main.showVehicleIdentificationPath(vehicle), true

    - if currentTab is 'version_comments'
      breadcrumbs.add new Models.Breadcrumb
        text: I18n.t(currentTab, scope: 'breadcrumb')
        callback: => Backbone.history.navigate Routers.Main.showVehicleCommentsPath(vehicle), true

    breadcrumbs

  @forProfile: (user, tab, vehicleType)->
    breadcrumbs = new Collections.Breadcrumbs

    currentUser = Store.get('currentUser')
    userProfilePath = Routers.Main.showUserProfilePath(user)
    isCurrentUser = currentUser? and currentUser.id == user.id

    if isCurrentUser
      breadcrumbs.add new Models.Breadcrumb
        text: I18n.t('myy_garage', scope: 'breadcrumb')
        callback: => Backbone.history.navigate userProfilePath, true
    else
      breadcrumbs.add new Models.Breadcrumb
        text: user.get('username')
        callback: => Backbone.history.navigate userProfilePath, true

    if vehicleType?
      translationText = "#{vehicleType}s"
    else
      translationText = tab
    translationText = "myy_#{translationText}" if isCurrentUser
    breadcrumbs.add new Models.Breadcrumb { text: I18n.t(translationText, scope: 'breadcrumb') }

  @forGallery: (gallery)->
    vehicle = gallery.get('vehicle')
    breadcrumbs = Collections.Breadcrumbs.forVehicle(vehicle)
    breadcrumbs.pop()

    showGalleriesCallback = =>
      Backbone.history.navigate Routers.Main.showUserVehiclePath(Store.get('currentUser'), vehicle)
      MyApp.layout.content.show new Pages.Vehicles.Show model: vehicle, currentTab: 'galleries'

    breadcrumbs.add new Models.Breadcrumb
      text: gallery.get('vehicle').longLabel()
      callback: showGalleriesCallback

    breadcrumbs.add new Models.Breadcrumb
      text: I18n.t('galleries', scope: 'breadcrumb')
      callback: showGalleriesCallback

    breadcrumbs.add new Models.Breadcrumb
      text: gallery.get('title') ||  I18n.t('untitled_gallery', scope: 'breadcrumb')

  @forImportedGallery: (tab, gallery)->
    breadcrumbs = Collections.Breadcrumbs.forMyyCloud(tab)
    breadcrumbs.add new Models.Breadcrumb
      text: gallery.get('title') ||  I18n.t('untitled_gallery', scope: 'breadcrumb')

  @forAlbum: (album)->
    breadcrumbs = new Collections.Breadcrumbs.forAlbums()

    breadcrumbs.add new Models.Breadcrumb
      text: "#{album.get('user').get('username')}"
      callback: => Backbone.history.navigate Routers.Main.showUserAlbumsPath(album.get('user').id), true

    breadcrumbs.add new Models.Breadcrumb
      text: album.get('title') ||  I18n.t('untitled_gallery', scope: 'breadcrumb')

  @forAlbums: ->
    breadcrumbs = new Collections.Breadcrumbs
    breadcrumbs.add new Models.Breadcrumb
      text: I18n.t('albums', scope: 'breadcrumb')
      callback: => Backbone.history.navigate Routers.Main.albumsPath(), true

  @forMyyCloud: (tab)->
    breadcrumbs = new Collections.Breadcrumbs
    breadcrumbs.add new Models.Breadcrumb
      text: I18n.t('me', scope: 'breadcrumb')
      callback: => Backbone.history.navigate Routers.Main.editMyProfilePath(), true

    breadcrumbs.add new Models.Breadcrumb
      text: I18n.t('myy_cloud', scope: 'breadcrumb')
      callback: => Backbone.history.navigate Routers.Main.myyCloudPath(), true

    breadcrumbs.add new Models.Breadcrumb
      text: I18n.t(tab, scope: 'breadcrumb')
      callback: => Backbone.history.navigate Routers.Main.myyCloudPath(tab), true
