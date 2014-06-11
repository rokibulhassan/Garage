//= require ./modifications_item

class Pages.Vehicles.Modifications.ModificationsItems extends Backbone.Marionette.CollectionView
  className: 'tab-content'
  itemView: Pages.Vehicles.Modifications.ModificationsItem

  initialize: ({@changeSets, @showControls, @parts, @vendors})->

  itemViewOptions: ->
    showControls: @showControls
    changeSets:   @changeSets
    parts:        @parts
    vendors:      @vendors