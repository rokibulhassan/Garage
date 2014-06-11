class Fragments.Vehicles.IdentificationShow extends Backbone.Marionette.Layout
  template: 'pages/vehicles/identification_show/identification_show'

  regions:
    mosaic: "#mosaic-container"
    sidebar:  "#vehicle-info-sidebar"

  initialize: ({@model, @versionAttributes})->
    @vehicle = @model

  onRender: ->
    @sidebar.show new Fragments.Vehicles.IdentificationShow.SidebarInfo
      version:           @vehicle.get('version')
      vehicle:           @vehicle
      versionAttributes: @versionAttributes
    @mosaic.show new Fragments.Vehicles.IdentificationShow.Mosaic model: @model
