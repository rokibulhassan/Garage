//= require ./created_at_mixin

class Models.Correction extends Backbone.RelationalModel
  relations: [
    {
    type:           Backbone.HasOne
    key:            'corrector'
    relatedModel:   'Models.User'
    collectionType: 'Collections.Users'
    includeInJSON:  'id'
    }
  ]
  
  initialize: ->
    _.extend @, Models.CreatedAtMixin
    @initializeCreatedAt()

  url: ->
    if @isNew()
      "/api/corrections?version_property_id=#{@get('version_property_id')}"
    else
      "/api/corrections/#{@id}"
