//= require ./created_at_mixin

class Models.VersionProperty extends Backbone.RelationalModel
  relations: [
    {
      type:            Backbone.HasOne
      key:             'user'
      relatedModel:    'Models.User'
      includeInJSON:   'id'
    }
    {
      type:               Backbone.HasMany
      key:                'corrections'
      relatedModel:       'Models.Correction'
      collectionType:     'Collections.Corrections'
      includeInJSON:      false
      reverseRelation: {
        key:           'version_property'
        includeInJSON: 'id'
        keySource:     'version_property_id'
      }
    }
  ]

  initialize: ->
    _.extend @, Models.CreatedAtMixin
    @initializeCreatedAt()
