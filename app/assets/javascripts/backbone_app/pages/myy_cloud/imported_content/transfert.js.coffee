#= require ./transfert_galleries

class Pages.MyyCloud.ImportedContent.Transfert extends Backbone.Marionette.Layout
  template:  'pages/myy_cloud/transfert'

  events:
    'click .transfert-tab' : 'tabClicked'

  regions:
    publicGalleries  : '#transfert_public_galleries'
    privateGalleries : '#transfert_private_galleries'

  initialize: ({@albums})->

  onRender: ->
    newAlbum = new Models.Album

    privateAlbums = new Collections.Albums @albums.where(privacy: 'private')
    privateAlbums.add newAlbum, at: 0

    @privateGalleries.show new Pages.MyyCloud.TransfertGalleries
      collection: privateAlbums
      pictures: @collection
      galleryPrivacy: 'private'

    publicAlbums = new Collections.Albums @albums.where(privacy: 'public')
    publicAlbums.add newAlbum, at: 0
    @publicGalleries.show  new Pages.MyyCloud.TransfertGalleries
      collection: publicAlbums
      pictures: @collection
      galleryPrivacy: 'public'

  tabClicked: (event)->
    $(event.target).tab('show')
    false