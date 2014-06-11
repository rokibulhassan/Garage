class Fragments.Users.ComparisonTablesRow extends Backbone.Marionette.ItemView
  template: 'pages/users/comparison_tables_row'
  tagName: 'tr'

  events:
    'click .vehicle-img'               : 'showVehicle'
    'click .comparison-table'          : 'showComparisonTable'
    'click .comparison-table-save-it'  : 'saveComparison'
    'click .comparison-table-like-it'  : 'likeComparison'
    
  initialize: ->
    @currentUser = Store.get('currentUser')
    @modelUser = @model.get('user')
    @canSave = @canLike = (@currentUser && @modelUser.id isnt @currentUser.id)
    @ownsComparison = @currentUser and !@canSave

  onRender: ->
    @$('.vehicle-img').tooltip()
    _.defer =>
      labelHeight = @$('.comparison-label-data a').height()
      if labelHeight > 45
        @$('.comparison-label-data').css({height: "#{labelHeight + 5}px"})

  showVehicle: (event) ->
    $target = $(event.currentTarget)
    $link = if $target.hasClass('.vehicle') then $target else $target.closest('.vehicle')
    comparisonTable = @model
    vehicle = comparisonTable.get('vehicles').get $link.data 'id'
    Backbone.history.navigate Routers.Main.showVehicleIdentificationPath(vehicle), true
    false

  showComparisonTable: (event) ->
    comparisonTable = @model
    if @ownsComparison
      Backbone.history.navigate Routers.Main.showMyComparisonPath comparisonTable
    else
      Backbone.history.navigate Routers.Main.showUserComparisonPath @modelUser, comparisonTable
    MyApp.layout.content.show new Pages.ComparisonTables.Show model: comparisonTable
    false

  saveComparison: (event) ->
    comparison = @model
    return false unless comparison && @currentUser
    comparisonSave = new Models.ComparisonTableSave
      comparison_table_id: comparison.id
    comparisonSave.save null, success: =>
      comparison.get('saves').push(1)
      @render()
    false

  likeComparison: (event) ->
    comparison = @model
    return false unless comparison && @currentUser
    comparisonLike = new Models.ComparisonTableLike
      comparison_table_id: comparison.id
    comparisonLike.save null, success: =>
      comparison.get('likes').push(1)
      @render()
    false

  serializeData: ->
    comparison: @model
    canSave: @canSave
    canLike: @canLike
