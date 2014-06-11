Views.Mixins.showVehicle = ->
  Backbone.history.navigate Routers.Main.showUserVehiclePath(@model.get('user'), @model), true
  false

Views.Mixins.showCompareBox = ->
  comparisonTables = new Collections.ComparisonTables
  comparisonTables.fetch success: =>
    modal = new Pages.Vehicles.CompareModal vehicle: @vehicle, comparisonTables: comparisonTables
    MyApp.modal.show modal
  false

Views.Mixins.addToBookmarks = ->
  vehicleBookmark = new Models.VehicleBookmark(vehicle: @vehicle)
  vehicleBookmark.save {}, {
    success: (model, response) =>
      @bookmarkedVehicles.add model.get('vehicle'), at: 0
      @updateBookmarkAbilities()
  }
  false

Views.Mixins.updateBookmarkAbilities = ->
  bookmarkedVehicleIds    = @bookmarkedVehicles.pluck('id')
  @canRemoveFromBookmarks = _.contains bookmarkedVehicleIds, @vehicle.id
  @render()

Views.Mixins.removeFromBookmarks = ->
  vehicleBookmark = new Models.VehicleBookmark(id: @vehicle.id, vehicle: @vehicle)
  vehicleBookmark.destroy success: (model, response) =>
    @bookmarkedVehicles.remove(@vehicle)
    @updateBookmarkAbilities()
  false
