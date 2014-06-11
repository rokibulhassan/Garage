class Models.Service extends Backbone.RelationalModel
  relations: [
    {
      type:           Backbone.HasOne
      key:            'vendor'
      relatedModel:   'Models.Vendor'
      includeInJSON:  'id'
      keyDestination: 'vandor_id'
    }
  ]