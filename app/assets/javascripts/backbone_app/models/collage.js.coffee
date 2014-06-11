Models.Collage = Backbone.RelationalModel.extend
  relations: [
    {
      type:            Backbone.HasMany
      key:             'cutouts'
      relatedModel:    'Models.Cutout'
      collectionType:  'Collections.Cutouts'
      includeInJSON:   false
      reverseRelation: {
        key:            'collage'
        keyDestination: 'collage_id'
        includeInJSON:  'id'
      }
    }
  ]
