class Models.Modification extends Backbone.RelationalModel
  relations: [
    {
      type:           Backbone.HasMany
      key:            'part_purchases'
      relatedModel:   'Models.PartPurchase'
      collectionType: 'Collections.PartPurchases'
      includeInJSON:   'id'
      reverseRelation:
        key: 'modification'
        includeInJSON: 'id'
        keySource:     'modification_id'
    }
    {
      type:           Backbone.HasMany
      key:            'services'
      relatedModel:   'Models.Service'
      collectionType: 'Collections.Services'
      includeInJSON:  'id'
      reverseRelation:
        key: 'modification'
        includeInJSON: 'id'
        keySource:     'modification_id'
    }
    {
      type:           Backbone.HasMany
      key:            'properties'
      relatedModel:   'Models.ModificationProperty'
      collectionType: 'Collections.ModificationProperties'
      includeInJSON:  'id'
      reverseRelation:
        key: 'modification'
        includeInJSON: 'id'
        keySource:     'modification_id'
    }
  ]