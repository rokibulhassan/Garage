class Models.Part extends Backbone.RelationalModel
  defaults:
    supplier_references: []

  urlRoot: '/parts'
  relations: [
    {
      type:           Backbone.HasOne
      key:            'brand'
      relatedModel:   'Models.Brand'
      includeInJSON:  'id'
      keyDestination: 'brand_id'
    }
  ]