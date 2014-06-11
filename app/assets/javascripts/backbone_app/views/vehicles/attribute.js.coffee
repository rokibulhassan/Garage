# Represente an attribute in the show vehicle page.
# It is displayed inside an attributes group.
#
# The main goal is to turn back an attribute object into a good looking string
# regardless the type of the attribute: static value, dynamic value, unit, etc.
class Views.Attribute extends Backbone.View
  tagName: 'tr'


  # attributeDefinition is a plain old object with the name and the label of the attribute.
  # attribute is the specific attribute for the vehicle.
  initialize: (attributes)->
    @attributeDefinition = attributes.attributeDefinition
    @attribute           = attributes.attribute


  render: ->
    key   = @attributeDefinition.label
    type  = @attributeDefinition.type

    switch type
      when 'dynamicChoice'          then @renderChoice()
      when 'staticChoice'           then @renderChoice()
      when 'numericDecimalWithUnit' then @renderNumericDecimalWithUnit()
      when 'numericInteger'         then @renderNumericInteger()
      else throw "Unknown field type '#{type}'."

    $key   = $('<td />', text: key, class: 'span3')
    $value = $('<td />', text: @value)

    $(@el).empty()
      .append($key)
      .append($value)

    @


  renderChoice: ->
    @value = @attribute?.get('label')


  renderNumericInteger: ->
    @value = @attribute?.get('value')


  renderNumericDecimalWithUnit: ->
    value  = @attribute?.get('value')
    unit   = @attribute?.get('unitLabel')
    @value = "#{value} #{unit}"
