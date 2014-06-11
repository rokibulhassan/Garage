Models.PropertyInstance = Backbone.RelationalModel.extend
  relations: [
    {
      type:         Backbone.HasOne
      key:          'property'
      relatedModel: 'Models.Property'
    }
    {
      type:           Backbone.HasMany
      key:            'propertyAttributeValues'
      relatedModel:   'Models.PropertyAttributeValue'
      collectionType: 'Collections.PropertyAttributeValues'
    }
  ]


  toJSON: ->
    property_id: @get('property')?.id
    property_attribute_values: @get('propertyAttributeValues').map (propertyAttributeValue)-> propertyAttributeValue.toJSON()
