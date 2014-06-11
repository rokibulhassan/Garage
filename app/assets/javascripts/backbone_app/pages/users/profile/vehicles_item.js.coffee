Fragments.Users.Profile.VehiclesItem = Backbone.Marionette.ItemView.extend
  template:  'fragments/users/profile/vehicle_item'
  tagName:   'li'

  events:
    'click a.thumbnail' : 'showVehicle'

  initialize: ->
    @version = @model.get('version')

  showVehicle: ->
    if @version.get('full_identity_data')
      Backbone.history.navigate Routers.Main.showVehicleIdentificationPath(@model), true
    else
      Backbone.history.navigate Routers.Main.showVehicleIdentificationEditPath(@model), true
    false

  serializeData: ->
    vehicle: @model
    caption: @model.longLabel()
    subcaption: "#{@version.get('production_year') || ''}"
