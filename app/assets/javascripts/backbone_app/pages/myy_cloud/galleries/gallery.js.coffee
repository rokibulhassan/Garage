class Pages.MyyCloud.Gallery extends Pages.Galleries.Show

  setBreadcrumbs: ->
    @breadcrumbs = Collections.Breadcrumbs.forImportedGallery("#{@gallery.get('privacy')}_galleries", @gallery)

  canManage: ->
    Models.Ability.canManageAlbum(@gallery)

  collagesEnabled: ->
    false
