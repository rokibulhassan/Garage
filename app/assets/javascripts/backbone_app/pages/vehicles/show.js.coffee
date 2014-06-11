 # The page to show a vehicle.
# This page display few components
#   - A title of the vehicle: the label of the brand and the model.
#   - A picture to illustrate the vehicle.
#   - A block of "quick information".
#   - A tabs container.
#
class Pages.Vehicles.Show extends Backbone.Marionette.Layout
  template: 'pages/vehicles/show'

  # Some tab-content blocks may be used as regions.
  regions:
    breadcrumb:          '#breadcrumb'
    identification:      '#identification'
    identification_show: '#identification_show'
    avatar:              '#avatar'
    galleries:           '#galleries'
    specifications:      '#specifications'
    expenses:            '#expenses'
    modifications:       '#modifications'
    performances:        '#performances'
    follow:              '#follow'
    version_comments:    '#version_comments'

  events:
    'click .add-bookmark'        : 'addToBookmarks'
    'click .remove-bookmark'     : 'removeFromBookmarks'
    'click .compare'             : 'showCompareBox'

    'click .delete-vehicle'      : 'deleteVehicle'
    'click .change_side_view'    : 'changeSideView'

    'show a.show-identification'      : 'showIdentificationEditTab'
    'show a.show-identification_show' : 'showIdentificationShowTab'
    'show a.show-galleries'      : 'showGalleriesTab'
    'show a.show-specifications' : 'showSpecificationsTab'
    'show a.show-expenses'       : 'showExpensesTab'
    'show a.show-modifications'  : 'showModificationsTab'
    'show a.show-performances'   : 'showPerformancesTab'
    'show a.show-version_comments' : 'showCommentsTab'
    'click .disabled'            : 'stopPropagation'

  showCompareBox: Views.Mixins.showCompareBox
  addToBookmarks: Views.Mixins.addToBookmarks
  updateBookmarkAbilities: Views.Mixins.updateBookmarkAbilities
  removeFromBookmarks: Views.Mixins.removeFromBookmarks

  initialize: ({@currentTab})->
    @tabNames     = ['galleries', 'performances', 'modifications', 'specifications', 'expenses', 'identification_show', 'identification', 'version_comments']
    # these tabs appear alone, without the other tabs
    @soloTabNames = ['version_comments']

    @vehicle = @model
    @replaceHistoryState = !@currentTab
    @currentTab ||= 'identification_show'
    if @currentTab is 'identification_show' and !@model.get('version')?.get('full_identity_data')
      @currentTab = 'identification'
    @owner = @user =  @model.get('user')
    @currentUser = Store.get('currentUser')

    if @currentUser?
      @bookmarkedVehicles = @currentUser.get('bookmarkedVehicles')
      @bookmarkedVehicles.onReset => @updateBookmarkAbilities()

    @bindTo @model, 'change:side_view', => @render()

  onRender: ->
    showBreadcrumbs = =>
      @breadcrumb?.show new Fragments.Breadcrumb.Index
        collection: Collections.Breadcrumbs.forVehicle @model, @currentTab
    callback = =>
      @$(".show-#{@currentTab}").trigger('click')
      showBreadcrumbs()
    hideAndShowBreadcrumbs = =>
      @breadcrumb?.close()
      showBreadcrumbs()

    @model.get('version').on('change:show_model_name', hideAndShowBreadcrumbs)
    @model.get('version').on('change:second_name', hideAndShowBreadcrumbs)

    if @currentUser?
      @currentUser.get('followings').fetch success: (followings) =>
        @follow?.show new Fragments.Users.Profile.Follow model: @user, followings: followings

    setTimeout(callback, 0)

  onClose: ->
    @model?.get('version').off('change:show_model_name')
    @model?.get('version').off('change:second_name')

  stopPropagation: ->
    false

  deleteVehicle: ->
    bootbox.confirm  'Are you sure?', (submit) =>
      if submit
        redirectPath = Routers.Main.showUserProfileVehiclesPath(@model.get('user'))
        promise = @model.destroy wait: true
        promise.done -> Backbone.history.navigate redirectPath, true
    false

  showIdentificationShowTab: ->
    $vehicleTabs = $('.vehicle-tabs')
    $vehicleTabs.find('.show-identification').closest('li').hide()
    $vehicleTabs.find('.show-identification_show').closest('li').show()
    @closeRegionIfOpen(@identification_show)
    @showIdentificationTab Routers.Main.showVehicleIdentificationPath(@model), (attrs) =>
      @identification_show.show new Fragments.Vehicles.IdentificationShow(attrs)

  showIdentificationEditTab: ->
    $vehicleTabs = $('.vehicle-tabs')
    $vehicleTabs.find('.show-identification_show').closest('li').hide()
    $vehicleTabs.find('.show-identification').closest('li').show()
    @closeRegionIfOpen(@identification)
    @showIdentificationTab Routers.Main.showVehicleIdentificationEditPath(@model), (attrs) =>
      @identification.show new Fragments.Vehicles.Identification(attrs)

  showIdentificationTab: (navPath, callback) ->
    if @replaceHistoryState
      Backbone.history.navigate(navPath, replace: true)
    else
      Backbone.history.navigate(navPath)
    @model.get('version').fetch success: (version) =>
      versionAttributes = new Models.VersionAttributes version: version
      versionAttributes.fetch success: (versionAttributes) =>
        @model.get('ownership').fetch success: =>
          generations = new Collections.Generations
          generations.version = version
          generations.fetch success: (generations) =>
            callback(
              model: @model
              version: @model.get('version')
              ownership: @model.get('ownership')
              versionAttributes: versionAttributes
              generations: generations
            )

  showGalleriesTab: ->
    @closeRegionIfOpen(@galleries)
    galleries = @model.get('galleries')
    galleries.fetch success: (galleries) =>
      Backbone.history.navigate Routers.Main.showUserVehiclePath(@owner, @model)
      @galleries.show new Fragments.Vehicles.Galleries
        model: @model
        collection: galleries

  showPerformancesTab: ->
    @closeRegionIfOpen(@performances)
    Backbone.history.navigate "#{Routers.Main.showVehiclePath @model}/performances"
    @model.get('version').get('data_sheet').fetch success: (dataSheet, response) =>
      @model.currentChengeSet().fetch success: (current_change_set) =>
        @performances.show new Fragments.Vehicles.Performances.Show
          version:            @model.get('version')
          dataSheet:          dataSheet
          vehicle:            @model
          current_change_set: current_change_set

  showCommentsTab: ->
    @closeRegionIfOpen(@version_comments)
    version = @model.get('version')
    version.set('vehicle', @model)
    comments = new Collections.PrewrittenVersionCommentsWithUsers()
    comments.version =  version
    promise = comments.fetch()
    promise.done =>
      comments.each (comment) ->
        comment.set('canManage', Models.Ability.canManageVehicle(version.get('vehicle')))
      @version_comments.show new Fragments.Vehicles.VersionComments
        model:      version
        collection: comments

  showSpecificationsTab: ->
    @closeRegionIfOpen(@specifications)
    Backbone.history.navigate "#{Routers.Main.showVehiclePath @model}/specifications"
    @model.get('version').get('data_sheet').fetch success: (dataSheet, response) =>
        @model.get('modifications').fetch success: (modifications, response) =>
          callback = (importToolAvailable, modelDataSheets) =>
            @specifications.show new Fragments.Vehicles.Specifications.Show
              version:             @model.get('version')
              dataSheet:           dataSheet
              vehicle:             @model
              modifications:       modifications
              importToolAvailable: importToolAvailable
              dataSheets:          modelDataSheets

          if ! _.any(dataSheet['attributes'], (attrs, name) => attrs?['value']?)
            dataSheets = new Collections.DataSheets()
            dataSheets.m_id =  @model.get('model').id
            dataSheets.fetch success: (datasheets, response) =>
              callback(true, datasheets)
          else
            callback(false, [])

  showExpensesTab: ->
    @closeRegionIfOpen(@expenses)
    parts = new Collections.Parts
    parts.fetch success: (parts) =>
      vendors = new Collections.Vendors
      vendors.fetch success: (vendors) =>
        @expenses.show new Fragments.Vehicles.Purchases
          collection: @model.get('part_purchases')
          vehicle: @model
          parts: parts
          vendors: vendors

  showModificationsTab: ->
    @closeRegionIfOpen(@modifications)
    Backbone.history.navigate "#{Routers.Main.showVehiclePath @model}/modifications"
    @model.get('modifications').fetch success: =>
      @model.get('change_sets').fetch success: =>
        parts = new Collections.Parts
        parts.fetch success: (parts) =>
          vendors = new Collections.Vendors
          vendors.fetch success: (vendors) =>
            @modifications.show new Pages.Vehicles.Modifications.Dashboard
              vehicle: @model
              parts: parts
              vendors: vendors

  closeRegionIfOpen: (region) ->
    region and region.close()

  changeSideView: ->
    side_views = new Collections.SideViews()
    side_views.fetch
      data:
        version_id: @model.get('version').id
      wait: true
      success: =>
        modal = new Modals.Vehicles.SideViews collection: side_views, vehicle: @model
        MyApp.modal.show modal
    false

  serializeData: ->
    vehicle:           @model
    canEditBookmarks:  !Models.Ability.canManageVehicle(@model) and @currentUser
    canAddToBookmarks: !@canRemoveFromBookmarks
    canManageVehicle:  Models.Ability.canManageVehicle @model
    canShowSideView:   Models.Ability.canShowVehicleSideView @model
    tabNames:          @tabNames
    soloTabNames:      @soloTabNames
    currentTab:        @currentTab
    hide_identification: @model.get('version').get('full_identity_data')
    hide_identification_show: !@model.get('version').get('full_identity_data')
    user: @user
    canAddToOpposers: @currentUser and @user.get('id') isnt @currentUser.get('id')
    canManage: @currentUser and @user.get('id') is @currentUser.get('id')
    currentUser: @currentUser
