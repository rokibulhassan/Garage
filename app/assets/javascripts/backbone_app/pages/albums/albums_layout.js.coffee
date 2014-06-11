class Pages.Albums.AlbumsLayout extends Backbone.Marionette.Layout
  template: 'pages/albums/albums'

  regions:
    breadcrumb:      '#breadcrumb'
    albumsContainer: '#albums'

  initialize: ({@albums})->

  onRender: ->
    @breadcrumb.show new Fragments.Breadcrumb.Index collection: new Collections.Breadcrumbs.forAlbums()
    @albumsContainer.show new Pages.Albums.Albums collection: @albums