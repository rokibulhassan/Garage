#= require ./created_at_mixin
#= require ./linkified_mixin

# WARN: Do not change to coffee script extends. It brakes reverse relation
Models.Picture = Backbone.RelationalModel.extend
  relations: [
    {
      type:           Backbone.HasMany
      key:            'comments'
      relatedModel:   'Models.Comment'
      collectionType: 'Collections.Comments'
      includeInJSON:  false
      reverseRelation: {
        key:           'picture'
        keySource:     'picture_id'
        includeInJSON: 'id'
      }
    }
    {
      type:            Backbone.HasMany
      key:             'cutouts'
      relatedModel:    'Models.Cutout'
      collectionType:  'Collections.Cutouts'
      includeInJSON:   false
      reverseRelation: {
        key:            'picture'
        keyDestination: 'picture_id'
        includeInJSON:  'id'
      }
    }
  ]

  initialize: ->
    _.extend @, Models.CreatedAtMixin
    @initializeCreatedAt()
    _.extend @, Models.LinkifiedMixin

  user: ->
    console.log @
    @get('gallery').get('vehicle').get('user')

  altText: ->
    @get('title') || "Picture #{@id}"

  millisecCreatedAt: ->
    datetime = @get('created_at')
    date = new Date(datetime.getFullYear(), datetime.getMonth(), datetime.getDate())
    datetime.getTime() - date.getTime()

  linkifiedTitle: ->
    @get('title') && @linkified @get('title')


  galleryTitle: ->
    console.log "a"
    @get('gallery').get('title') || 'Untitled gallery'

  swapDimensions: ->
    width = @get('big_width')
    height = @get('big_height')
    @set('big_width', height)
    @set('big_height', width)

  scaleToLimit: (maxWidth, maxHeight)->
    ratio =  @get('big_width') / @get('big_height')
    @bigWidth = @get('big_width')
    @bigHeight = @get('big_height')

    if @bigWidth > maxWidth
      @bigWidth = maxWidth
      @bigHeight = Math.round(maxWidth / ratio)

    if @bigHeight > maxHeight
      @bigWidth = Math.round(maxHeight * ratio)
      @bigHeight = maxHeight

    @marginLeft = Math.min(- (@bigWidth / 2), -280)
    @marginTop = - (@bigHeight / 2)

    @