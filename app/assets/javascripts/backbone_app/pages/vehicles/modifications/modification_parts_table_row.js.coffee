class Pages.Vehicles.Modifications.ModificationPartsTableRow extends Backbone.Marionette.ItemView
  tagName: 'tr'
  template: 'pages/vehicles/modifications/modification_parts_table_row'

  events:
    'change .attribute': 'changeModificationPart'
    'click .remove'    : 'destroyModificationPart'
    'click .create-new-vendor'  : 'showCreateVendorModal'

  initialize: ({@vehicle, @parts, @showControls, @parent, @vendors})->
    @bindTo @model, 'change', @render if @parent instanceof Models.ChangeSet

  serializeData: ->
    parts:        @parts
    vendors:      @vendors
    quantity:     @model.get 'quantity'
    price:        @model.get 'price'
    part:         @model.get 'part'
    vendor:       @model.get 'vendor'
    main:         @model.get 'main'
    showControls: @showControls


  changeModificationPart: ->
    @model.set 'part', @parts.get @$('select.part').val()
    @model.set 'vendor', @vendors.get @$('select.vendor').val()

    if @model.get('part') and @model.get('vendor')
      @model.save @collectData(), wait: true

    false


  collectData: ->
    main:     @$('input.main').prop 'checked'
    quantity: @$('input.quantity').val()
    price:    @$('input.price').val().replace ',', '.'

  showCreateVendorModal: ->
    modal = new Modals.Vendors.New()

    @bindTo modal, 'vendor:created', (vendor)=>
      @model.set vendor: vendor
      @vendors.add vendor
      @render()

    MyApp.modal.show(modal)

    false

  destroyModificationPart: ->
    @model.destroy()

    false

  onRender: ->
    @setAfterCallBacks()

  setAfterCallBacks: ->
    callbacks = => @$('select').chosen(no_results_text: ' ')
    setTimeout callbacks, 0
