class Layouts.Main extends Backbone.Marionette.Layout
  template: 'layouts/main'

  regions:
    topBar:  '#top-bar'
    content: '#content'

  initialize: ->
    @withoutTopBar = false
    @on('item:rendered', @renderSubViews)

  renderSubViews: ->
    @topBar.show(new Views.TopBar) unless @withoutTopBar == true

  serializeData: ->
    currentUser: Store?.get('currentUser')
