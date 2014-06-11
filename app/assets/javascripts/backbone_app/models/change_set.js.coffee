class Models.ChangeSet extends Backbone.RelationalModel
  relations: [
    {
      type:           Backbone.HasMany
      key:            'modifications'
      relatedModel:   'Models.Modification'
      collectionType: 'Collections.Modifications'
      keySource:      'modification_ids'
      includeInJSON:  false
    }
    {
      type:           Backbone.HasMany
      key:            'part_purchases'
      relatedModel:   'Models.PartPurchase'
      collectionType: 'Collections.PartPurchases'
      includeInJSON:   'id'
    }
    {
      type:           Backbone.HasMany
      key:            'services'
      relatedModel:   'Models.Service'
      collectionType: 'Collections.Services'
      includeInJSON:  'id'
    }
    {
      type:           Backbone.HasMany
      key:            'properties'
      relatedModel:   'Models.ChangeSetProperty'
      collectionType: 'Collections.ChangeSetProperties'
      includeInJSON:  false
      reverseRelation:
        key: 'change_set'
        includeInJSON: 'id'
        keySource: 'change_set_id'
    }
  ]