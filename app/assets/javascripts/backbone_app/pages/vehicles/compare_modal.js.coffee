class Pages.Vehicles.CompareModal extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/compare_modal'

  events:
    'click .actions .compare-later'           : 'createComparisonTable'
    'click .actions .compare-now'             : 'createComparisonTableAndShow'
    'click .comparison-tables .compare-later' : 'addToComparisonTableLater'
    'click .comparison-tables .compare-now'   : 'addToComparisonTableAndShow'

  initialize: ({@vehicle, @comparisonTables})->

  serializeData: ->
    comparisonTables: @comparisonTables

  createComparisonTable: ->
    @addToComparisonTable @buildComparisonTable(), false
    false

  createComparisonTableAndShow: ->
    @addToComparisonTable @buildComparisonTable(), true
    false

  addToComparisonTableLater: (event)->
    @addToComparisonTable @getComparisonTableBy(event), false
    false

  addToComparisonTableAndShow: (event)->
    @addToComparisonTable @getComparisonTableBy(event), true
    false

  buildComparisonTable: ->
    comparisonTable = new Models.ComparisonTable
    comparisonTable.collection = @comparisonTables

    comparisonTable

  getComparisonTableBy: (event)->
    id = $(event.target).parents('tr').data 'id'
    @comparisonTables.get id

  addToComparisonTable: (comparisonTable, showComparations)->
    comparisonTable.get('vehicles').add @vehicle
    comparisonTable.save {},
      wait: true
      success: (model, response)=>
        MyApp.layout.content.show new Pages.ComparisonTables.Show(model: model) if showComparations
        @close()
      error: (model, response)=>
        model.get('vehicles').remove @vehicle
        @close()

    false