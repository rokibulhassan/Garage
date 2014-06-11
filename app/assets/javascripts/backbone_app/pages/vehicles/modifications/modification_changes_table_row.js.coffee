class Pages.Vehicles.Modifications.ModificationChangesTableRow extends Backbone.Marionette.ItemView
  tagName: 'tr'
  template: 'pages/vehicles/modifications/modification_changes_table_row'

  events:
    'change .property-name'  : 'changeProperty'
    'change .property-value' : 'changeValue'
    'click .remove'          : 'removeRow'


  initialize: ({@vehicle, @showControls, @propertyDefinitions})->

  serializeData: ->
    property:            @model
    showControls:        @showControls
    unit:                I18n.t(Seeds.propertyDefinitions[@model.get('name')], scope: 'units_new.unit_symbols') || ''
    propertyDefinitions: @propertyDefinitions

  changeProperty: ->
    @model.set 'name', @$('.property-name').val()
    @render()

    false

  changeValue: ->
    @$('.property').attr('disabled', true).trigger "liszt:updated"
    @model.save @collectData(),
      success: =>
        delete @propertyDefinitions[@model.get 'name']
        @render()
      error: =>
        @render()

    false

  collectData: ->
    value: @$('.property-value').val().replace(',', '.')

  removeRow: ->
    @model.destroy()

    false

  onRender: ->
    @setAfterCallBacks()

  setAfterCallBacks: ->
    callbacks = => @$('select').chosen(no_results_text: ' ')
    setTimeout callbacks, 0