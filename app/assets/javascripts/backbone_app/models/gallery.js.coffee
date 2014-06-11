class Models.Gallery extends Backbone.RelationalModel
  relations: [
    {
      type:            Backbone.HasMany
      key:             'pictures'
      relatedModel:    'Models.Picture'
      collectionType:  'Collections.Pictures'
      includeInJSON:   false
      reverseRelation: {
        key:           'gallery'
        includeInJSON: false
      }
    }
    {
      type:            Backbone.HasMany
      key:             'collages'
      relatedModel:    'Models.Collage'
      collectionType:  'Collections.Collages'
      includeInJSON:   false
      reverseRelation: {
        key:            'gallery'
        keyDestination: 'gallery_id'
        includeInJSON:  'id'
      }
    }
  ]
