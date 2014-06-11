class Pages.Vehicles.Modifications.ModificationServicesTableRow extends Backbone.Marionette.ItemView
  tagName: 'tr'
  template: 'pages/vehicles/modifications/modification_services_table_row'

  events:
    'change .service-attribute' : 'changeService'
    'click .remove'             : 'removeRow'
    'click .create-new-vendor'  : 'showCreateVendorModal'

  initialize: ({@types, @parent, @vendors, @showControls})->
    @bindTo @model, 'change', @render if @parent instanceof Models.ChangeSet


  serializeData: ->
    type:         @model.get 'service_type'
    vendor:       @model.get 'vendor'
    vendors:      @vendors
    duration:     @model.get 'duration_type'
    types:        @types
    showControls: @showControls

  changeService: ->
    @model.save @collectData(), wait: true

  collectData: ->
    service_type:   @$('select.type').val()
    duration_type:  @$('input.duration').val()
    vendor_id:      @$('select.vendor').val()

  removeRow: ->
    @model.destroy()

  showCreateVendorModal: ->
    modal = new Modals.Vendors.New()

    @bindTo modal, 'vendor:created', (vendor)=>
      @model.set vendor: vendor
      @vendors.add vendor
      @render()

    MyApp.modal.show(modal)

    false

  onRender: ->
    @setAfterCallBacks()

  setAfterCallBacks: ->
    callbacks = => @$('select').chosen(no_results_text: ' ')
    setTimeout callbacks, 0