# Used to display a vehicle page.
# It display a group of attributes for a given vehicle.
class Views.AttributesGroup extends Backbone.View
  template:  JST['vehicles/attributes_group']
  className: 'welle'


  # The group is a Backbone.Model with a name and a label, and an attributes
  # array containing attributes descriptors (plain object with name and label).
  initialize: (attributes)->
    @group   = attributes.group
    @vehicle = attributes.vehicle


  # If the vehicle has no value for attributes of this group, don't show it at all.
  render: ->
    $html                 = $(@template(group: @group))
    $attributes           = $html.find('.attributes')
    vehicleAttributes     = @vehicle.get('attributes')
    groupAttributes       = _(@group.get('attributes')) # Become "each-able".
    filledAttributesCount = 0

    groupAttributes.each (attribute)=>
      vehicleAttribute = vehicleAttributes.findByName(attribute.name)

      if vehicleAttribute
        filledAttributesCount += 1
        subview = new Views.Attribute
          attributeDefinition: attribute
          attribute:           vehicleAttribute

        $el = $(subview.render().el)
        $attributes.append($el)

    $(@el).html($html) if 0 < filledAttributesCount
    @
