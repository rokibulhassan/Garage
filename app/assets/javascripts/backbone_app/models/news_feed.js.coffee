class Models.NewsFeed extends Backbone.RelationalModel
  relations: [
    {
      type:           Backbone.HasOne
      key:            'initiator'
      relatedModel:   'Models.User'
      keyDestination: 'initiator_id'
      includeInJSON:  'id'
    }
    {
      type:     Backbone.HasMany
      key:  'vehicles'
      relatedModel: 'Models.Vehicle'
      collectionType: 'Collections.Vehicles'
      includeInJSON: false
    }
  ]
