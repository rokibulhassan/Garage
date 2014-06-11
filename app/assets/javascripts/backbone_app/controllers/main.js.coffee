Controllers.Main =
  home: ->
    @dashboard()

  dashboard: ->
    newsFeeds = new Collections.NewsFeeds
    newsFeeds.fetch success: =>
      MyApp.layout.content.show new Pages.Dashboard.Show
        newsFeeds: newsFeeds

  myDashboard: ->
    newsFeeds = new Collections.NewsFeeds
    newsFeeds.fetch data: {my: true}, success: =>
      MyApp.layout.content.show new Pages.Dashboard.Show
        newsFeeds: newsFeeds
        myNews: true

  myFavorites: ->
    attributes = userId: Store.get('currentUser').get('id')
    MyApp.layout.content.show(new Pages.Favorites(attributes))

  myBookmarks: ->
    bookmarkedVehicles = Store.get('currentUser').get('bookmarkedVehicles')
    bookmarkedVehicles.onReset ->
      vehicles = new Collections.UserVehicles(bookmarkedVehicles.models)
      MyApp.layout.content.show(new Pages.Vehicles.Bookmarks(vehicles: vehicles))

  myProfile: (activeTab, vehicleType = null) ->
    Store.get('currentUser').get('vehicles').fetch data: {type: vehicleType}, success: =>
      MyApp.layout.content.show new Pages.Users.Profile
        model: Store.get('currentUser')
        activeTab: activeTab
        vehicleType: vehicleType

  myProfileVehicles: ->
    @myProfile 'vehicles'

  myProfileCars: ->
    @myProfile 'vehicles', 'automobile'

  myProfileBikes: ->
    @myProfile 'vehicles', 'motorcycle'

  showUserAlbums: (userId)->
    albums = new Collections.Albums
    albums.fetch data: {user_id: userId, public: true}, success: (albums) =>
      MyApp.layout.content.show new Pages.Albums.AlbumsLayout albums: albums

  editMyProfile: (tab)->
    countries = new Collections.Countries
    countries.fetch success: (countries) =>
      MyApp.layout.content.show new Pages.Users.EditMyProfile
        model: Store.get('currentUser')
        countries: countries
        currentTab: tab

  myPeople: (tab)->
    Store.get('currentUser').get('followings').fetch success: (followings) =>
      Store.get('currentUser').get('followers').fetch success: (followers) =>
        MyApp.layout.content.show new Pages.Users.People
          model:      Store.get('currentUser')
          followings: followings
          followers:  followers
          activeTab:  tab

  showMyComparisons: ->
    comparisonTables = new Collections.ComparisonTables
    comparisonTables.fetch success: =>
      MyApp.layout.content.show new Pages.Users.ComparisonTables
        comparisonTables: comparisonTables
        user: Store.get('currentUser')

  showMyComparison: (id) ->
    comparisonTable = new Models.ComparisonTable id: id
    comparisonTable.collection = new Collections.ComparisonTables
    comparisonTable.fetch success: ->
      MyApp.layout.content.show new Pages.ComparisonTables.Show
        model: comparisonTable

  showUserComparison: (userId, id) ->
    @showMyComparison(id)

  showUserProfileComparisons: (userId) ->
    @showUserProfile(userId, 'comparisons')

  showRecentComparisons: ->
    comparisonTables = new Collections.ComparisonTables
    comparisonTables.fetch data: { recent: true }, success: =>
      MyApp.layout.content.show new Pages.Users.ComparisonTables
        comparisonTables: comparisonTables
        user: null

  newVehicle: ->
    MyApp.layout.content.show(new Pages.Vehicles.New)

  searchVehicles: ->
    brands = new Collections.Brands
    brands.fetch(data: { include_pending: false })
    brands.onReset ->
      countries = new Collections.Countries
      countries.fetch()
      countries.onReset ->
        MyApp.layout.content.show new Pages.Vehicles.Search
          brands: brands
          countries: countries

  searchVehiclesCars: ->
    brands = new Collections.Brands
    brands.fetch(data: { include_pending: false })
    brands.onReset ->
      countries = new Collections.Countries
      countries.fetch()
      countries.onReset ->
        MyApp.layout.content.show new Pages.Vehicles.Search
          brands: brands
          countries: countries
          type: 'automobile'

  searchVehiclesBikes: ->
    brands = new Collections.Brands
    brands.fetch(data: { include_pending: false })
    brands.onReset ->
      countries = new Collections.Countries
      countries.fetch()
      countries.onReset ->
        MyApp.layout.content.show new Pages.Vehicles.Search
          brands: brands
          countries: countries
          type: 'motorcycle'

  showAlbums: ->
    albums = new Collections.Albums
    albums.fetch data: {public: true}, success: (albums) ->
      MyApp.layout.content.show new Pages.Albums.AlbumsLayout
        albums: albums

  showAlbum: (albumId)->
    album = new Models.Album id: albumId
    album.fetch success: (album) ->
      album.get('pictures').fetch success: ->
        MyApp.layout.content.show new Pages.Albums.Gallery
          gallery: album

  showMyyCloud: (tab)->
    Store.get('currentUser').get('profile_pictures').fetch success: (pictures) ->
      albums = new Collections.Albums
      albums.fetch success: (albums) ->
        MyApp.layout.content.show new Pages.MyyCloud.Layout
          pictures: pictures
          activeTab: tab
          albums: albums

  showUserVehicle: (userId, vehicleId, currentTab) ->
    user = new Models.User id: userId
    user.fetch success: ->
      vehicle = new Models.Vehicle id: vehicleId
      vehicle.collection = user.get('vehicles')
      vehicle.fetch success: ->
        MyApp.layout.content.show new Pages.Vehicles.Show
          currentTab: currentTab
          model: vehicle

  showUserProfile: (userId, activeTab, vehicleType) ->
    user = new Models.User id: userId
    user.fetch success: =>
      user.get('vehicles').fetch data: {type: vehicleType}, success: ->
        comparisonTables = new Collections.ComparisonTables
        comparisonTables.fetch data: {user_id: user.id}, success: (comparisonTables) ->
          MyApp.layout.content.show new Pages.Users.Profile
            model: user
            activeTab: activeTab
            comparisonTables: comparisonTables
            vehicleType: vehicleType

  showUserProfileVehicles: (userId)->
    @showUserProfile userId, 'vehicles'

  showUserProfileCars: (userId)->
    @showUserProfile userId, 'vehicles', 'automobile'

  showUserProfileBikes: (userId)->
    @showUserProfile userId, 'vehicles', 'motorcycle'

  showProfilePictures: (userId)->
    userFetchedCallback = (model, response)->
      model.get('profile_pictures').fetch success: (collection, response) =>
        MyApp.layout.content.show new Pages.MyyCloud.ImportedContent
          pictures: collection
    if Store.get('currentUser')? and Store.get('currentUser').id.toString() == userId
      userFetchedCallback Store.get('currentUser')
    else
      user = new Models.User id: userId
      user.fetch success: userFetchedCallback

  newProfilePicture: (userId)->
    MyApp.layout.content.show new Pages.Profiles.PicturesNew

  showGallery: (vehicleId, galleryId)->
    vehicle = new Models.Vehicle id: vehicleId
    vehicle.collection = new Collections.Vehicles
    vehicle.fetch success: =>
      gallery = new Models.Gallery id : galleryId
      vehicle.get('galleries').add(gallery)
      gallery.fetch success: =>
        vehicle.get('user').fetch success: =>
          view = new Pages.Galleries.Show(gallery: gallery)
          MyApp.layout.content.show(view)

  showVehicle: (vehicleId, currentTab)->
    vehicle = new Models.Vehicle(id: vehicleId)
    vehicle.collection = new Collections.Vehicles
    vehicle.fetch success: ->
      vehicle.get('user').fetch success: =>
        MyApp.layout.content.show new Pages.Vehicles.Show
          model: vehicle
          currentTab: currentTab

  showSpecificationsTab: (vehicleId)->
    @showVehicle vehicleId, 'specifications'

  showPerformancesTab: (vehicleId)->
    @showVehicle vehicleId, 'performances'

  showModificationsTab: (vehicleId)->
    @showVehicle vehicleId, 'modifications'

  showIdentificationTab: (vehicleId)->
    @showVehicle vehicleId, 'identification_show'

  showIdentificationEditTab: (vehicleId)->
    @showVehicle vehicleId, 'identification'

  showVehicleComments: (vehicleId) ->
    @showVehicle vehicleId, 'version_comments'
