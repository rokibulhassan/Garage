class Models.Brand extends Backbone.RelationalModel
  relations: [
    {
      type:           Backbone.HasMany
      key:            'models'
      relatedModel:   'Models.Model'
      collectionType: 'Collections.Models'
      reverseRelation:
        key: 'brand'
        keyDestination: 'brand_id'
        includeInJSON:  'id'
    }
  ]
