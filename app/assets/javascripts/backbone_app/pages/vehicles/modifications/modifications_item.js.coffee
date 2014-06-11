class Pages.Vehicles.Modifications.ModificationsItem extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/modifications/modifications_item'
  className: 'tab-pane'
  events:
    'click .add-part'         : 'addModificationPart'
    'click .add-service'      : 'addService'
    'click .add-change'       : 'addChange'
    'click .delete-modification' : 'deleteModification'

  initialize: ({@changeSets, @showControls, @parts, @vendors})->
    @changes          = @model.get('properties')
    @changes.modification    = @model

    @initializePropertyDefinitions()

  initializePropertyDefinitions: ->
    if @showControls
      @propertyDefinitions = _.extend {}, Seeds.propertyDefinitions
      @model.get('properties').each (definition)=>
        delete @propertyDefinitions[definition.get('name')]

  onRender: ->
    @$el.attr 'id', "#{if @model instanceof Models.Modification then "modification" else "changeset"}_item_#{@model.id}"

    @prependParts()
    @prependServices()
    @prependProperties()

  prependParts: ->
    new Pages.Vehicles.Modifications.ModificationPartsTable(
      el:           @$ '.parts tbody'
      collection:   @model.get 'part_purchases'
      vehicle:      @model.get 'vehicle'
      parent:       @model
      showControls: @showControls
      parts:        @parts
      vendors:      @vendors

    ).render()

  prependServices: ->
    new Pages.Vehicles.Modifications.ModificationServicesTable(
      el:           @$('.services tbody')
      collection:   @model.get 'services'
      parent:       @model
      vendors:      @vendors
      showControls: @showControls
    ).render()

  prependProperties: ->
    new Pages.Vehicles.Modifications.ModificationChangesTable(
      el:                  @$(".changes tbody")
      collection:          @changes
      vehicle:             @model.get 'vehicle'
      showControls:        @showControls
      propertyDefinitions: @propertyDefinitions
    ).render()

  serializeData: ->
    label:  @model.get 'label'
    showControls: @showControls
    ableToDelete: Models.Ability.canDeleteModification @model, @changeSets

  addModificationPart: ->
    @model.get('part_purchases').add new Models.PartPurchase main: false, vehicle_id: @model.get('vehicle').id

    false

  addService: ->
    @model.get('services').add new Models.Service

    false

  addChange: ->
    @changes.add new Models.ModificationProperty

    false

  deleteModification: ->
    @model.destroy()