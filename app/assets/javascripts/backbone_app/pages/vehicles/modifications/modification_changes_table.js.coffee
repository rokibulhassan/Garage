//= require ./modification_changes_table_row
class Pages.Vehicles.Modifications.ModificationChangesTable extends Backbone.Marionette.CollectionView
  itemView: Pages.Vehicles.Modifications.ModificationChangesTableRow

  initialize: ({@vehicle, @showControls, @propertyDefinitions})->

  itemViewOptions: ->
    vehicle:             @vehicle
    showControls:        @showControls
    propertyDefinitions: @propertyDefinitions