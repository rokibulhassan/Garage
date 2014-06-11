class Models.Vehicle extends Backbone.RelationalModel

  relations: [
    {
      type:           Backbone.HasOne
      key:            'brand'
      relatedModel:   'Models.Brand'
      includeInJSON:  false
    }
    {
      type:           Backbone.HasOne
      key:            'model'
      relatedModel:   'Models.Model'
      includeInJSON:  false
    }
    {
      type:         Backbone.HasOne
      key:          'ownership'
      relatedModel: 'Models.Ownership'
      includeInJSON: false
      reverseRelation:
        type:          Backbone.HasOne
        key:           'vehicle'
        includeInJSON: 'id'
        keySource:     'vehicle_id'
    }
    # NOTE: on client side, Vehicle has one version but on server-side Vehicle
    # belongs_to Version... I have no idea why (Luke), but assume it's a
    # mistake.
    {
      type:         Backbone.HasOne
      key:          'version'
      relatedModel: 'Models.Version'
      includeInJSON: 'id'
      keyDestination: 'version_id'
    }
    {
      type:         Backbone.HasOne
      key:          'collage'
      relatedModel: 'Models.DefaultVehicleCollage'
      includeInJSON: 'id'
      keyDestination: 'vehicle_id'
      reverseRelation:
        type:          Backbone.HasOne
        key:           'vehicle'
        includeInJSON: 'id'
        keySource:     'vehicle_id'
    }
    {
      type:           Backbone.HasMany
      key:            'pictures'
      relatedModel:   'Models.VehicleIdentificationPicture'
      collectionType: 'Collections.VehicleIdentificationPictures'
      includeInJSON: false
      reverseRelation:
        key:           'vehicle'
        includeInJSON: 'id'
        keySource:     'vehicle_id'
    }
    {
      type:           Backbone.HasMany
      key:            'all_gallery_pictures'
      relatedModel:   'Models.VehicleGalleryPicture'
      collectionType: 'Collections.VehicleGalleryPictures'
      includeInJSON: false
      reverseRelation:
        key:           'vehicle'
        includeInJSON: 'id'
        keySource:     'vehicle_id'
    }
    {
      type:           Backbone.HasMany
      key:            'part_purchases'
      relatedModel:   'Models.PartPurchase'
      collectionType: 'Collections.PartPurchases'
      includeInJSON: false
      reverseRelation:
        key:           'vehicle'
        includeInJSON: 'id'
        keySource:     'vehicle_id'
    }
    {
      type:            Backbone.HasMany
      key:             'galleries'
      relatedModel:    'Models.Gallery'
      collectionType:  'Collections.Galleries'
      includeInJSON: false
      reverseRelation: {
        key:           'vehicle'
        keySource:     'vehicle_id'
        includeInJSON: 'id'
      }
    }
    {
      type:           Backbone.HasMany
      key:            'modifications'
      relatedModel:   'Models.Modification'
      collectionType: 'Collections.Modifications'
      includeInJSON: false
      reverseRelation:
        key: 'vehicle'
    }
    {
      type:           Backbone.HasMany
      key:            'change_sets'
      relatedModel:   'Models.ChangeSet'
      collectionType: 'Collections.ChangeSets'
      includeInJSON:   false
      reverseRelation:
        key: 'vehicle'
        keySource:     'vehicle_id'
        includeInJSON: 'id'
    }
    {
      type:           Backbone.HasOne
      key:            'side_view'
      relatedModel:   'Models.SideView'
      includeInJSON:  'id'
      keyDestination: 'side_view_id'
    }

  ]

  currentChengeSet: ->
    changeSet = new Models.ChangeSet
    changeSet.url = @get('change_sets').url().replace 'change_sets', 'current_change_set'
    changeSet

  currentChangeSet: ->
    @currentChengeSet.apply(this, arguments)

  longLabel: ->
    prefix = $.trim(
      @get('brand').get('name')
    )
    if @isAuto()
      if @get('version')?.get('show_model_name')
        prefix = $.trim "#{prefix} #{(@get('model')?.get('name') || '')}"
      else
      $.trim "#{prefix} #{(@get('version')?.get('name') || '')}"
    else
      prefix = $.trim "#{prefix} #{(@get('model')?.get('name') || '')}"
      prefix = $.trim "#{prefix} #{(@get('version')?.get('name') || '')}"
      if @get('version')?.get('show_model_name')
        $.trim "#{prefix} #{(@get('version')?.get('second_name') || '')}"
      else
        prefix

  sideViewUrl: (imageType = 'thumb') ->
    @get('side_view')?.get("#{imageType}_url") || @defaultSideViewUrl(imageType)

  sideViewId: ->
    if @get('side_view')?.id
      @get('side_view').id
    else
      'default'

  defaultSideViewUrl: (imageType = 'thumb') ->
    Models.SideView.defaultPathFor @get('type'), imageType

  hasDefaultSideView: (imageType = 'thumb')->
    @sideViewUrl(imageType) is @defaultSideViewUrl(imageType)

  sideViewWidth: (imageType = 'thumb') ->
    thumb = @get('side_view')?.get('image_dimensions')?.thumb
    if thumb then thumb.width else Models.SideView.defaultSizeFor(@get('type'))[0]

  sideViewHeight: (imageType = 'thumb') ->
    thumb = @get('side_view')?.get('image_dimensions')?.thumb
    if thumb then thumb.height else Models.SideView.defaultSizeFor(@get('type'))[1]

  hasBody: ->
    @isAuto()

  normalAvatarUrl: ->
    image = @get('avatars')?.normal
    image?.url || ''

  isAuto: ->
    @get('type') == 'automobile'

  isMoto: ->
    @get('type') == 'motorcycle'

  allAliases:
    automobile: { body: 'body',   model: 'model',    version: 'version' }
    motorcycle: { body: 'category', model: 'engine', version: 'model', transmission_type: 'selector'   }

  aliases: ->
    @allAliases[@get('type')]
