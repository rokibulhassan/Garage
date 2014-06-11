//= require ./comparison_tables_rows

class Pages.Users.ComparisonTables extends Backbone.Marionette.Layout
  template: 'pages/users/comparison_tables'

  regions:
    'search_area' : '#search-area'

  events:
    'click .custom-search' : 'toggleSearchForm'

  initialize: ({@comparisonTables, @user}) ->
    @currentUser = Store.get('currentUser')
    @userForAvatarRegion = if @user then @user else @currentUser
    @setBindings()
    @page = 1

  setBindings: ->
    $win = $(window)
    $doc = $(document)
    $win.on 'scroll', _.throttle( =>
      if $win.scrollTop() >= $doc.height() - $win.height() - 10
        @paginate()
    , 1500)

  paginate: ->
    return if @fetchingPaginationData
    @fetchingPaginationData = true
    newComparisons = new Collections.ComparisonTables()
    data = @searchData()
    data.page = @page + 1
    promise = newComparisons.fetch(data: data)
    promise.then (collection, response, options) =>
      unless _.isEmpty(collection)
        @page += 1
        @comparisonTables.add(collection)
        @renderTableRows()
    promise.complete =>
      @fetchingPaginationData = false

  searchData: ->
    return {} unless @searchAreaView
    _.clone(@searchAreaView.data)

  onRender: ->
    if !@searchAreaView
      @brands = new Collections.Brands()
      promise = @brands.fetch()
      promise.then (brands) =>
        @searchAreaView = new Fragments.Users.ComparisonTablesSearchArea
          brands: @brands
        @searchAreaView.on 'new_results', (newResults) =>
          @$el.find('.custom-search').click()
          @comparisonTables = newResults
          @clearTableRows()
          @renderTableRows()
        @search_area.show @searchAreaView
    @renderTableRows()

  onClose: ->
    if @searchAreaView
      @searchAreaView.off('new_results')
    $(window).off('scroll')

  renderTableRows: ->
    rows = new Fragments.Users.ComparisonTablesRows
      collection: @comparisonTables
      el: @$el.find('tbody')
    rows.render()

  clearTableRows: ->
    @$('tbody').html('')

  toggleSearchForm: (e) ->
    $form = $(e.currentTarget).siblings('form')
    if $form.is(':hidden')
      $form.show()
    else
      $form.hide()
    false

  getTitle: ->
    if @user && @currentUser.id is @user.id
      I18n.t('comparison_tables.my_comparison_tables_title')
    else if @user
      I18n.t('comparison_tables.comparison_tables_title_for_name', name: @user.get('username'))
    else
      I18n.t('comparison_tables.comparison_tables_recent_title')

  serializeData: ->
    title: @getTitle()
