class Modals.Vehicles.SideViews extends Backbone.Marionette.ItemView
  template:  'modals/vehicles/side_views'
  className: 'modal'

  events:
    'click .side_views .side_view'  : 'assignSideView'

  initialize: ({@vehicle}) ->

  serializeData: ->
    side_views: @collection

  assignSideView: (e) =>
    side_view_id = $(e.target).data 'side_view_id'
    @vehicle.save { side_view: @collection.get(side_view_id) }, wait: true
    @close()

    false