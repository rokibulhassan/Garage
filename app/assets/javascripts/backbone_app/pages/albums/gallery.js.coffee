#= require backbone_app/pages/galleries/show

class Pages.Albums.Gallery extends Pages.Galleries.Show

  setBreadcrumbs: ->
    @breadcrumbs = Collections.Breadcrumbs.forAlbum(@gallery)

  canManage: ->
    false

  collagesEnabled: ->
    false