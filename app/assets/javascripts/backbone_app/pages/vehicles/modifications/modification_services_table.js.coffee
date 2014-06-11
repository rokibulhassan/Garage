//= require ./modification_services_table_row
class Pages.Vehicles.Modifications.ModificationServicesTable extends Backbone.Marionette.CollectionView
  itemView: Pages.Vehicles.Modifications.ModificationServicesTableRow

  initialize: ({@parent, @vendors, @showControls})->

  itemViewOptions: ->
    types:        ['part_removal', 'part_installation', 'bodywork', 'preparation']
    parent:       @parent
    vendors:      @vendors
    showControls: @showControls
