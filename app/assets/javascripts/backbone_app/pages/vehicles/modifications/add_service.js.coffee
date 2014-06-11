Pages.Vehicles.Modifications.AddService = Backbone.Marionette.ItemView.extend
  template: 'pages/vehicles/modifications/add_service'

  events:
    'change #vendor_id' : 'changeVendor'
    'submit form'       : 'createService'

  types: [ 'part_removal', 'part_installation', 'bodywork', 'preparation' ]


  initialize: (attributes)->
    @service = new Models.Service(vehicle: attributes.vehicle)
    @vendors = new Collections.Vendors

    @vendors.fetch()


  createService: ->
    @service.set
      label:       @$('#label').val()
      price:       @$('#price').val()
      duration:    @$('#duration').val()
      serviceType: @$('#service_type').val()
      date:        @$('#date').val()

    @service.save()
    @trigger('service:created', @service)
    false


  changeVendor: (event)->
    vendor = @vendors.get(event.target.value)
    @service.set(vendor: vendor)


  onRender: ->
    callback = => @$('select').chosen(no_results_text: ' ')
    setTimeout(callback, 0)

    view = new Vendors(el: @$('#vendor_id'), collection: @vendors)
    view.render()


  serializeData: ->
    types: @types



Vendor = Backbone.Marionette.ItemView.extend
  tagName: 'option'

  renderHtml: ->
    $(@el).text(@model.get('name')).val(@model.id)
    undefined



Vendors = Backbone.Marionette.CollectionView.extend
  itemView: Vendor

  onRender: ->
    $(@el).trigger('liszt:updated')


