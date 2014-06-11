Pages.Vehicles.Search = Backbone.Marionette.Layout.extend
  template: 'pages/vehicles/search'

  regions:
    searchResults: '#vehicles-search-results'

  events:
    'change select.chosen' : 'selectChosenChanged'
    'submit form'          : 'fetchSearchResults'
    'click .custom-search' : 'showSearchForm'

  initialize: ({@brands, @countries, @type})->
    @searchParams = {type: @type}
    @bindTo(MyApp.vent, 'vehicles:search:results', @showSearchResults)
    @fetchSearchResults()

  onRender: ->
    @customSearchLink = @$('#custom-search a.custom-search')
    @customSearchForm = @$('#vehicles-search')

    callback = =>
      $('select').chosen(no_results_text: ' ', allow_single_deselect: true)
    setTimeout(callback, 0)

  serializeData: ->
    brands:    @brands
    countries: @countries

  selectChosenChanged: (event)->
    input = event.currentTarget
    @searchParams[input.name] = $(input).val()

  fetchSearchResults: ->
    @searchParams.query = $('input[name=query]').val()
    Collections.UserVehicles.search(@searchParams)
    false

  showSearchForm: ->
    @customSearchLink.hide()
    @customSearchForm.show()

  hideSearchForm: ->
    @customSearchLink.show()
    @customSearchForm.hide()

  showSearchResults: (foundVehicles) ->
    @searchResults.show(new Fragments.Vehicles.Search.Results(collection: foundVehicles))
    @hideSearchForm()
