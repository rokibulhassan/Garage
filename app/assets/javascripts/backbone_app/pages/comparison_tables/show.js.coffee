class Pages.ComparisonTables.Show extends Backbone.Marionette.Layout
  className: 'comparison_tables'
  template: 'pages/comparison_tables/show'

  regions:
    'follow' : '#follow'

  events:
    'change input.label'                  : 'changeLabel'
    'change input.change-set'             : 'toggleProperties'
    'change input.toggle-show-properties' : 'toggleShowProperties'
    'click .remove-vehicle'               : 'removeVehicle'
    'click .vehicle-link'                 : 'goToVehicleIdentification'
    'click .tab-switch'                   : 'activateNewTab'
    'click .add-opposer'                  : 'addToUserOpposers'
    'click .comparison-table-liker-saver-username-link' : 'goToUserProfile'

  initialize: ({})->
    @canManage = Models.Ability.canManageComparisonTable(@model)
    @vehicles = @model.get('vehicles')
    @hiddenChangeSetIds = []
    @currentTab = 'performance_comparison_attributes_set'
    @currentSubTab = 'likers'
    @currentUser = Store.get('currentUser')

  onRender: ->
    _.defer =>
      @activateTab()
      @showTooltips()
      @renderVehicleSideViews()

    if @currentUser?
      @currentUser.get('followings').fetch success: (followings)=>
        @follow.show new Fragments.Users.Profile.Follow model: @model.get('user'), followings: followings

  activateTab: ->
    callbacks = =>
      $tab = @$("a[href=##{@currentTab}]")
      $tab.tab 'show'
      if $tab.hasClass('has-subtabs')
        @$("a[href=##{@currentSubTab}]").tab 'show'
      @$('.bar-data').filter(':visible').each (i, el) =>
        right = parseInt($(el).css('right'), 10)
        height = $(el).height()
        width = $(el).width()
        if right + width >= 625
          offset = right + width - 625
          $(el).css(right: "#{right - offset}px")
          $vehicleImg = $(el).closest('.vehicle-row').find('.vehicle-link')
          imgLeft = parseInt($vehicleImg.css('left'), 10)
          $vehicleImg.css(left: "#{imgLeft + offset}px")

    setTimeout callbacks, 0

  activateNewTab: (e) ->
    $target = $(e.currentTarget)
    tabName = $target.data('tab-name')
    isSubTab = $target.hasClass('is-subtab')
    if isSubTab
      @currentSubTab = tabName
    else
      @currentTab = tabName
    @activateTab()
    e.preventDefault()

  addToUserOpposers: ->
    bootbox.confirm(
      "Are you sure to block <strong>#{@model.get('user').get('username')}</strong> permanently?",
      (submit) =>
        if submit
          userOpposition = new Models.UserOpposition
          userOppositionAttrs =
            opposer_id: @model.get('user').id
          userOpposition.save userOppositionAttrs,
            wait: true
    )
    false

  goToUserProfile: (e) ->
    $target = $(e.currentTarget)
    userId = $target.data('user-id')
    path = Routers.Main.showUserProfilePath(userId)
    Backbone.history.navigate path, true
    false

  showTooltips: ->
    @$('.vehicle-row-img').tooltip()

  renderVehicleSideViews: ->
    sideViewMaxWidth = 110
    @$('.vehicle-side-view img').each (i, img) =>
      $img = $(img)
      width = $img.width()
      return if width <= sideViewMaxWidth
      moveLeft = width - sideViewMaxWidth
      $img.css(right: "#{moveLeft}px")

  toggleProperties: (e) ->
    return false unless @canManage
    $target = $(e.target)
    @model.save {selected_change_set_ids: @collectSelectedChangeSetIds()}, success: =>
      @render()

  toggleShowProperties: (e) ->
    return false if @canManage
    $target = $(e.target)
    @showOrHidePropertiesForChangeSet($target.val())

  showOrHidePropertiesForChangeSet: (changeSetId) ->
    if _.include(@hiddenChangeSetIds, changeSetId.toString())
      @hiddenChangeSetIds = _.reject @hiddenChangeSetIds, (id) ->
        id.toString() is changeSetId.toString()
    else
      @hiddenChangeSetIds.push(changeSetId.toString())
    @render()

  goToVehicleIdentification: (e) ->
    $target = $(e.currentTarget)
    vehicleId = $target.data('vehicle-id')
    vehicle = @vehicles.get(vehicleId)
    return false unless vehicle
    Backbone.history.navigate Routers.Main.showVehicleIdentificationPath(vehicle), true
    false

  collectSelectedChangeSetIds: ->
    @$("input.change-set:checked").serializeArray().map (e)->
      e.value

  changeLabel: (e) ->
    return false unless @canManage
    @model.save @collectData(), wait: true
    false

  collectData: ->
    label: @$('input.label').val()

  removeVehicle: (e) ->
    return false unless @canManage
    @vehicles.remove $(e.target).data 'id'
    @model.save {}, success: =>
      @render()
    false

  serializeData: ->
    checkAllChangeSets =
    if @canManage
      @model.get('selected_change_set_ids') is null || @model.get('selected_change_set_ids').length is 0
    else
      false
    selected = @model.get('selected_change_set_ids')
    if selected is null
      selected = _.flatten(@vehicles.map (v) -> v.get('change_sets').map (change) -> change.id)
    selectedChangeSetIds =
    if @canManage
      selected
    else
      _.reject selected, (id) =>
        _.include(@hiddenChangeSetIds, id.toString())

    comparisonTable:         @model
    canManage:               @canManage
    vehicles:                @vehicles
    comparisonAttributes:    @model.get 'comparison_attributes'
    propertyValuesHash:      @model.get 'properties'
    checkAllChangeSets:      checkAllChangeSets
    selectedChangeSetIds:    selectedChangeSetIds.map (id) -> id.toString()
    user: @model.get('user')
    canAddToOpposers: Models.Ability.canAddToOpposers(@model.get('user').get('username'))
    likers: @model.get('likers')
    savers: @model.get('savers')
