class Fragments.Vehicles.Specifications.PropertiesItem extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/specifications/properties_item'
  tagName: 'tr'

  events:
    'change .property-value'               : 'changeValue'
    'click .inactive .unit-alternate-link' : 'changeUnit'

  initialize: ({@showControls, @modifications, @vehicle})->
    @modded = @modifications.reduce((memo, modification)=>
      property = modification.get('properties').find (property)=> property.get('name') is @model.get('name')

      if property? and property.get('value')? then  memo + property.get('value') else memo
    , 0)
    @currentUser = Store.get('currentUser')
    @hpShow = true
    @kwShow = false
    @NmShow = true
    @kgmShow = false
    @bindTo MyApp.vent, '[specifications]render', (options) =>
      @render()

  changeValue: ->
    @model.save @collectData()
    false

  unitTranslationTable:
    'hp to kw'  : (hp)  -> hp / 1.36
    'kw to hp'  : (kw)  -> kw * 1.36
    'Nm to kgm' : (nm)  -> nm * 0.0981
    'kgm to Nm' : (kgm) -> kgm / 0.0981

  changeUnit: (e) ->
    $target = $(e.currentTarget)
    from = $target.data('unit-alternate-from')
    to   = $target.data('unit-alternate-to')
    this["#{from}Show"] = false
    this["#{to}Show"]   = true
    oldData = @collectDataRaw()
    newData = Math.round(@unitTranslationTable["#{from} to #{to}"](oldData) * 100) / 100
    @unitValue = newData
    @render()
    false

  collectDataRaw: ->
    @$('.property-value').val().replace(',', '.')

  collectData: ->
    val = @collectDataRaw()
    if @kwShow
      val = @unitTranslationTable['kw to hp'](val)
    if @kgmShow
      val = @unitTranslationTable['kgm to Nm'](val)
    value: val
    vehicle_id: @vehicle.id

  serializeData: ->
    showControls: @showControls
    propertyName: @model.get('name')
    value:        @unitValue || @model.get('value')
    unit:         I18n.t(Seeds.propertyDefinitions[@model.get('name')], scope: 'units_new.unit_symbols') || ''
    modded:       @modded
    isEditing:    @$('.property-value').length isnt 0
    kwShow:       @kwShow
    kgmShow:      @kgmShow
