Backbone.Marionette.Renderer.render = (template, data)->
  throw "Template '#{template}' not found!" unless JST[template]
  JST[template](data)


window.Store = new Backbone.Model
window.MyApp = new Backbone.Marionette.Application

MyApp.addRegions
  content: '#application'
  modal:   Views.ModalRegion
  innerModal: Views.InnerModalRegion


MyApp.addInitializer ->
  new Routers.Main

  MyApp.layout = new Layouts.Main

  # Backbone-relational issue#91
  new Models.User # otherwise the app won't work correctly for guest users

  if Seeds.currentUser
    currentUser = new Models.User(Seeds.currentUser)
    currentUser.set('bookmarkedVehicles', new Collections.UserVehicles)
    Collections.UserVehicles.bookmarks(currentUser.get('bookmarkedVehicles'))
    I18n.locale = currentUser.get('locale')
    Store.set('currentUser', currentUser)

  else
    I18n.locale = 'fr'
    Store.set('currentUser', null)

  MyApp.layout.on 'render', (layout)->
    Backbone.history.start(pushState: true)

  MyApp.content.show(MyApp.layout)


jQuery ->
  MyApp.start()
