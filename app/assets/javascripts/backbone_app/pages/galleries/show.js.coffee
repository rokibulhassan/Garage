class Pages.Galleries.Show extends Backbone.Marionette.Layout
  id: 'gallery'
  template: 'pages/galleries/show'

  regions:
    breadcrumb:    '#breadcrumb'
    galleryLayout: '#gallery-layout'
    follow: '#follow'

  events:
    'click .add-bookmark'             : 'addToBookmarks'
    'click .remove-bookmark'          : 'removeFromBookmarks'
    'click .compare'                  : 'showCompareBox'

    'click   .delete'                 : 'deleteGallery'
    'keyup   #gallery-title'          : 'submitTitle'
    'blur    #gallery-title'          : 'hideTitleInput'
    'click   .edit-collages'          : 'editCollages'
    'click   .edit-collages-out'      : 'editCollagesOut'
    'change  .gallery-mosaic-input'   : 'switchViewAs'
    'change  .gallery-privacy-input'  : 'switchPrivacyStatus'
    'click   .switch-edit-mode-input' : 'switchEditMode'

  showCompareBox: Views.Mixins.showCompareBox
  addToBookmarks: Views.Mixins.addToBookmarks
  updateBookmarkAbilities: Views.Mixins.updateBookmarkAbilities
  removeFromBookmarks: Views.Mixins.removeFromBookmarks

  editCollages   : Views.Mixins.editCollages
  editCollagesOut: Views.Mixins.editCollagesOut
  renderCollages : Views.Mixins.renderCollages

  initialize: ({@gallery, @addPicturesList})->
    @pictureUrl = @gallery.get('pictures').url()

    @bindTo @, 'gallery:edit', @showTitleInput
    @bindTo(@gallery, 'change:title', => @renderTitle())

    @vehicle = @gallery.get('vehicle')
    @user = @vehicle.get('user')

    @setBreadcrumbs()
    @currentUser = Store.get('currentUser')

    @isEditing = @gallery.justCreated is true
    @collageMode = 'collages_list'
    if @gallery.get('layout') is 'collages'
      @gallery.get('pictures').fetch()

    if @currentUser
      @bookmarkedVehicles = @currentUser.get('bookmarkedVehicles')
      @bookmarkedVehicles.onReset => @updateBookmarkAbilities()

  onRender: ->
    @initializeFileUpload() if @canManage()

    if @currentUser?
      @currentUser.get('followings').fetch success: (followings) =>
        @follow?.show new Fragments.Users.Profile.Follow model: @user, followings: followings

    @breadcrumb? && @breadcrumb.show new Fragments.Breadcrumb.Index
      collection: @breadcrumbs

    unless @addPicturesList
      layout = if @collageMode == 'collages_edit' then 'collages' else @gallery.get('layout')
      @switchLayout(layout)

  setBreadcrumbs: ->
    @breadcrumbs = Collections.Breadcrumbs.forGallery(@gallery)
    if @canManage()
      @breadcrumbs.models.last().set
        editable: true
        callback: _.bind(@showTitleInput, this)

  collagesEnabled: ->
    true

  canManage: ->
    Models.Ability.canManageVehicle(@gallery.get('vehicle'))

  initializeFileUpload: ()->
    return unless @isEditing

    $fileInputs = @$('input[type=file]')
    if $fileInputs.length is 0 || $fileInputs.data().fileupload? then return

    $f = $fileInputs.fileupload()

    $f.on 'fileuploadadd', (event, data)=>
      picture = new Models.Picture
        gallery        : @gallery
        upload_progress: '0%'
      data.formData =
        client_id: picture.cid

    $f.on 'fileuploadprogress', (event, data)=>
      @gallery.get('pictures').getByCid(data.formData.client_id)
        .set upload_progress: parseInt(data.loaded / data.total * 100, 10) + '%'

    $f.on 'fileuploaddone', (event, data)=>
      pictureAttrs = data.result
      @gallery.get('pictures').getByCid(data.formData.client_id)
        .unset('upload_progress', { silent: true })
        .set(pictureAttrs)
        .initializeCreatedAt()

    $f.on 'fileuploadstart', (event, data)=>
      @$('ul.thumbnails').sortable('disable')

    $f.on 'fileuploadstop', (event, data)=>
      @gallery.get('pictures').sort()
      @$('ul.thumbnails').sortable('enable')

    if @addPicturesList?
      @galleryLayout? && @galleryLayout.show new Fragments.Galleries.Pictures
        collection: @gallery.get('pictures')
        canManage: true

      callback = =>
        @$('input[type=file]').fileupload('add', files: @addPicturesList)
        @addPicturesList = null
      setTimeout callback, 0

  showGalleries: ->
    @breadcrumbs.showGalleries()

  showTitleInput: ->
    callback = =>
      @$('#gallery-title').val(@gallery.get('title')).show().focus()
    setTimeout(callback, 0)

  submitTitle: (event)->
    event.stopPropagation()
    if event.which == 13
      @updateTitle()
      event.preventDefault()

  updateTitle: ->
    galleryAttrs =
      title: @$('#gallery-title').val()
    @gallery.save galleryAttrs, wait: true
    @hideTitleInput()

  hideTitleInput: ->
    @$('#gallery-title').hide()

  renderTitle: ->
    @breadcrumbs.last().set('text', @gallery.get('title'))

  deleteGallery: ->
    bootbox.confirm(
      'Are you sure?',
      (submit)=>
        if submit
          @gallery.destroy({wait: true})
          @showGalleries()
    )
    false

  switchLayout: (layout)->
    if layout == 'collages'
      @switchCollageLayout()
    else
      @switchGridLayout()

  switchGridLayout: ->
    promise = @gallery.get('pictures').fetch()
    promise.then =>
      @galleryLayout? && @galleryLayout.show new Fragments.Galleries.Pictures
        collection: @gallery.get('pictures')
        canManage:  @canManage()

  switchCollageLayout: ->
    promise = @gallery.get('collages').fetch()
    promise.then =>
      @renderCollages(@gallery.get('collages'), @galleryLayout)

  switchViewAs: (e) ->
    layout = if $(e.currentTarget).is(':checked') then 'collages' else 'grid'
    galleryAttrs =
      layout: layout
    @gallery.save galleryAttrs, wait: true, success: =>
      @switchLayout(layout)

  switchPrivacyStatus: (e) ->
    privacy =
      if $(e.currentTarget).is(':checked')
        'private'
      else
        'public'
    @gallery.save(privacy: privacy)

  switchEditMode: ->
    if @isEditing
      @editCollagesOut()
    @isEditing = not @isEditing
    @render()
    false

  serializeData: ->
    pictureUrl: @pictureUrl
    canManage: @canManage()
    collagesEnabled: @collagesEnabled()
    vehicle: @vehicle
    user: @user
    privacy: @gallery.get('privacy')
    isEditing: @canManage() && @isEditing
    isMosaic: @gallery.get('layout') is 'collages'
    canEditBookmarks: !Models.Ability.canManageVehicle @vehicle
    canAddToBookmarks: !@canRemoveFromBookmarks
    canAddToOpposers: @user?.get('id') && @currentUser?.get('id') && (@user.get('id') isnt @currentUser.get('id'))
    canShowSideView: Models.Ability.canShowVehicleSideView @vehicle
