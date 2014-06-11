class Fragments.Vehicles.Specifications.Show extends Backbone.Marionette.Layout
  template: 'pages/vehicles/specifications/show'

  events:
    'click .edit-properties' : 'editProperties'
    'click .view-properties' : 'viewProperties'

  initialize: ({@version, @dataSheet, @vehicle, @modifications, @importToolAvailable, @dataSheets})->
    @engineSpecNames =  ["cylinders", "displacement", "max_power", "max_power_frequency", "max_torque", "max_torque_frequency"]
    @chassisSpecNames = ["weight", "length", "width", "height"]
    @activePropertyRequests = 0

    @collections = {}
    @showControls = false

    @bindTo MyApp.vent, "[specifications]fill-own", =>
      @importToolAvailable = false
      @showControls = true
      @render()

    @bindTo MyApp.vent, "[specifications]import-datasheet", (dataSheet)=>
      @importToolAvailable = @showControls = false
      @importDataSheet(dataSheet) if Models.Ability.canImportDataSheet(dataSheet)

  onRender: ->
    if @importToolAvailable
      @renderImportTool()
    else if @activePropertyRequests == 0
      @renderView 'engine'
      @renderView 'chassis'
    MyApp.vent.trigger '[specifications]render', showControls: @showControls

  renderImportTool: ->
    new Fragments.Vehicles.Specifications.ImportTool(
      el:         @$("#import-tool")
      collection: @dataSheets
      model:      @vehicle
      version:    @version
      dataSheets: @dataSheets
    ).render()

  renderView: (group)->
    new Fragments.Vehicles.Specifications.Properties(
      el:            @$("#vehicle-#{group}-specs")
      collection:    @collections[group] || @buildProperties(group)
      showControls:  @showControls
      group:         group
      modifications: @modifications
      vehicle:       @vehicle
    ).render()

  buildProperties: (group)->
    properties = new Collections.VersionProperties
    properties.version = @version
    for name in @["#{group}SpecNames"]
      properties.add new Models.VersionProperty(@dataSheet.get(name))
    @collections[group] = properties

  importDataSheet: (dataSheet)->
    @importGroup 'engine', dataSheet
    @importGroup 'chassis', dataSheet

  importGroup: (group, dataSheet)->
    @collections[group] = new Collections.VersionProperties
    @collections[group].version = @version
    for name in @["#{group}SpecNames"]
      property = new Models.VersionProperty name: dataSheet.get(name)["name"], value: dataSheet.get(name)["value"]
      property.collection = @collections[group]
      @activePropertyRequests += 1
      property.save {}, wait: true, success: (property) =>
        @activePropertyRequests -= 1
        @collections[group].add property
        @render()

  editProperties: ->
    @showControls = true
    @render()
    false

  viewProperties: ->
    @showControls = false
    @render()
    false

  serializeData: ->
    showControls:        @showControls
    importToolAvailable: @importToolAvailable
    approved:            @vehicle.get('approved')
