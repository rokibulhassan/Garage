class Pages.Vehicles.Modifications.Dashboard extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/modifications/dashboard'
  id: 'modifications-dashboard'

  events:
    'click .add-new-change-set'    : 'addChangeSet'
    'click .change-set-nav'        : 'showChangeSet'
    'click #new-modification-item' : 'addModification'

  initialize: ({@vehicle, @parts, @vendors})->
    @modifications = @vehicle.get 'modifications'
    @changeSets    = @vehicle.get 'change_sets'

    @bindTo @changeSets,    'add remove', =>
      @render()
      @activateModificationTab @modifications.first()
    @bindTo @modifications, 'add remove', (newModification)=>
      @render()
      @activateModificationTab newModification


  addModification: ->
    MyApp.modal.show new Pages.Vehicles.Modifications.ModificationsNew modifications: @modifications

  addChangeSet: ->
    MyApp.modal.show new Pages.Vehicles.Modifications.ChangeSetsNew changeSets: @changeSets

  onRender: ->
    @renderChangeSetItems()
    @renderModificationItems()

  serializeData: ->
    changeSets:    @changeSets
    modifications: @modifications

  renderModificationItems: ->
    modificationsItemsView = new Pages.Vehicles.Modifications.ModificationsItems
      collection:   @modifications
      changeSets:   @changeSets
      showControls: Models.Ability.canManageVehicle @vehicle
      parts:        @parts
      vendors:      @vendors

    @$('#all-modifications').append modificationsItemsView.render().el
    @activateModificationTab @modifications.first()

  renderChangeSetItems: ->
    @changeSets.each (changeSet)=>
      changeSetItemView = new Pages.Vehicles.Modifications.ChangeSetItem model: changeSet, modifications: @modifications
      @$('.tab-content').append changeSetItemView.render().el

  showChangeSet: (e)->
    target = $(e.target)
    changeSet = @changeSets.get target.data 'id'
    changeSet.get('part_purchases').reset()
    changeSet.get('services').reset()
    changeSet.fetch
      success: =>
        target.tab 'show'

    false

  activateModificationTab: (modification)->
    callbacks = =>
      @$(".nav-pills a[href=#all-modifications]").tab 'show'
      @$("a[href=#modification_item_#{modification.id}]").tab 'show' if modification?
    setTimeout callbacks, 0