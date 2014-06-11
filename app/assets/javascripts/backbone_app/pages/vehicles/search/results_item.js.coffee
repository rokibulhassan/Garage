Fragments.Vehicles.Search.ResultsItem = Backbone.Marionette.ItemView.extend
  template:  'fragments/vehicles/search/results_item'
  tagName:   'li'

  events:
    'click a.thumbnail' : 'showVehicle'

  showVehicle: Views.Mixins.showVehicle


  serializeData: ->
    vehicle:    @model
    caption:    @model.longLabel()
    subcaption: "#{@model.get('version')?.get('production_year') || ''}"
