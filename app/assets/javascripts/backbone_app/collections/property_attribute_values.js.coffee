Collections.PropertyAttributeValues = Backbone.Collection.extend
  findOrBuildByPropertyAttribute: (propertyAttribute)->
    position = propertyAttribute.get('position')
    result   = @where(position: position)[0] || (
      tmp = new Models.PropertyAttributeValue(position: position, propertyAttribute: propertyAttribute)
      @add(tmp)
      tmp
    )
    result
