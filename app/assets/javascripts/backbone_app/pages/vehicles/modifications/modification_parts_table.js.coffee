#= require ./modification_parts_table_row
class Pages.Vehicles.Modifications.ModificationPartsTable extends Backbone.Marionette.CollectionView
  itemView: Pages.Vehicles.Modifications.ModificationPartsTableRow

  initialize: ({@vehicle, @parent, @showControls, @parts, @vendors})->

  itemViewOptions: ->
    vehicle:      @vehicle
    parts:        @parts
    showControls: @showControls
    parent:       @parent
    vendors:      @vendors
