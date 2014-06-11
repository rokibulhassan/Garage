Models.PropertyAttributeValue = Backbone.RelationalModel.extend
  relations: [
    {
      type:         Backbone.HasOne
      key:          'propertyAttribute'
      relatedModel: 'Models.PropertyAttribute'
    }
  ]


  toJSON: ->
    property_attribute_id: @get('propertyAttribute').id
    position:              @get('propertyAttribute').get('position')
    value:                 @get('value')
