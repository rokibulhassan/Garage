class Fragments.Vehicles.Performances.Show extends Backbone.Marionette.Layout
  template: 'pages/vehicles/performances/show'

  events:
    'click .edit-properties' : 'editProperties'
    'click .view-properties' : 'viewProperties'

  initialize: ({@version, @dataSheet, @vehicle, @modifications, @current_change_set}) ->
    @top_speed_prop_names = ["top_speed"]
    @ownsVehicle = @vehicle.get('user').id is Store.get('currentUser').id

    @acceleration_prop_dependencies =
      accel_time_0_60_kph    : 'accel_distance_0_60_kph'
      accel_time_0_100_kph   : 'accel_distance_0_100_kph'
      accel_time_0_160_kph   : 'accel_distance_0_160_kph'
      accel_time_0_200_kph   : 'accel_distance_0_200_kph'
      accel_time_0_300_kph   : 'accel_distance_0_300_kph'
      accel_time_100_200_kph : 'accel_distance_100_200_kph'
      accel_time_200_300_kph : 'accel_distance_200_300_kph'
      accel_time_0_96_kph    : 'accel_distance_0_96_kph'
      accel_time_96_209_kph  : 'accel_distance_96_209_kph'
      time_on_402            : 'max_speed_on_402'
      time_on_1000           : 'max_speed_on_1000'
      time_on_1609           : 'max_speed_on_1609'

    @acceleration_main_prop_names      = Object.keys @acceleration_prop_dependencies
    @acceleration_dependant_prop_names = Object.values @acceleration_prop_dependencies

    @deceleration_prop_names = [
      'decel_distance_100_0_kph',
      'decel_distance_113_0_kph',
      'decel_distance_200_0_kph'
    ]

    @emissions_prop_names = ["CO2_emissions"]
    @consumption_prop_names = ["consumption_city", "consumption_highway", "consumption_mixed"]

    @showCurrent = @current_change_set.get('properties').length > 0
    @collections = {}
    @showControls = false

  onRender: ->
    @renderView 'top_speed', column: 'left'
    @renderMultiLevelView 'acceleration', column: 'left'
    @renderView 'deceleration', column: 'right'
    @renderView 'emissions', column: 'right'
    @renderView 'consumption', column: 'right'

  renderView: (group, options = {}) ->
    new Fragments.Vehicles.Performances.Properties(_.extend options,
      el:                 @$("#vehicle-#{group}-specs")
      collection:         @propsCollection(group)
      showControls:       @showControls
      showCurrent:        @showCurrent
      group:              I18n.t(group, scope: 'performances.table')
      current_change_set: @current_change_set
      vehicle:            @vehicle
    ).render()


  renderMultiLevelView: (group, options = {}) ->
    new Fragments.Vehicles.Performances.Properties(_.extend options,
      el:                   @$("#vehicle-#{group}-specs")
      collection:           @propsCollection("#{group}_main")
      dependant_collection: @propsCollection("#{group}_dependant")
      props_dependencies:   @["#{group}_prop_dependencies"]
      showControls:         @showControls
      showCurrent:          @showCurrent
      current_change_set:   @current_change_set
      group:                I18n.t(group, scope: 'performances.table')
      vehicle:              @vehicle
    ).render()

  propsCollection: (group) ->
    @collections[group] || @buildProperties(group)

  buildProperties: (group) ->
    properties = new Collections.VersionProperties
    properties.version = @version
    for name in @["#{group}_prop_names"]
      properties.add new Models.VersionProperty(@dataSheet.get(name))
    @collections[group] = properties

  editProperties: ->
    @showControls = true
    @render()
    false

  viewProperties: ->
    @showControls = false
    @render()
    false

  serializeData: ->
    showControls: @showControls
