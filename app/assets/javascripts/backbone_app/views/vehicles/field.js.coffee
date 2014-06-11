class Views.Field extends Backbone.View
  events:
    'change .choice select'         : 'choiceChanged'
    'change .text input'            : 'inputChanged'
    'change .text-with-unit select' : 'unitChanged'
    'change .text-with-unit input'  : 'unitValueChanged'


  initialize: (attributes)->
    @vehicle       = attributes.vehicle
    @attributeName = @model.get('name')

    @vehicle.get('attributes').on('change', @attributeChanged)


  attributeChanged: =>
    @render() if @attributeName is 'model'


  render: ->
    @viewData =
      name:  @attributeName
      label: @model.get('label')
      value: @fetchVehicleAttribute(@attributeName).get('value')

    switch @model.get('type')
      when 'dynamicChoice'          then @renderChoicesMenu()
      when 'staticChoice'           then @renderChoicesMenu()
      when 'numericDecimalWithUnit' then @renderNumericDecimalWithUnit()
      when 'numericInteger'         then @renderNumericInteger()
      else throw 'Unknown field type.'

    $(@el).html(@$input)
    @


  renderChoicesMenu: ->
    allowedValues = @model.get('allowedValues')
    if @attributeName is 'model'
      chosenBrand   = @fetchVehicleAttribute('brand').get('value')
      allowedValues = @filterByBrandName(allowedValues, chosenBrand)

    @viewData.choices = @collectionToChoices(allowedValues)
    @$input = $(JST['inputs/select'](@viewData))


  renderNumericDecimalWithUnit: ->
    units = new Backbone.Collection(@model.get('units'))

    @viewData.units = @collectionToChoices(units)
    @viewData.value = @fetchVehicleAttribute(@attributeName).get('value')
    @viewData.unit  = @fetchVehicleAttribute(@attributeName).get('unit')
    @$input = $(JST['inputs/text_with_unit'](@viewData))


  renderNumericInteger: ->
    @$input = $(JST['inputs/text_field'](@viewData))


  choiceChanged: (event)->
    $select    = $(event.currentTarget)
    attribute  = @fetchVehicleAttribute(@attributeName)
    valueLabel = $select.find('option:selected').text()

    attribute.set(value: $select.val(), label: valueLabel)


  unitChanged: (event)->
    $select    = $(event.currentTarget)
    attribute  = @fetchVehicleAttribute(@attributeName)
    valueLabel = $select.find('option:selected').text()

    attribute.set(unit: $select.val(), label: valueLabel)


  unitValueChanged: (event)->
    $input    = $(event.currentTarget)
    attribute = @fetchVehicleAttribute(@attributeName)

    attribute.set(value: $input.val())


  inputChanged: (event)->
    $input    = $(event.currentTarget)
    attribute = @fetchVehicleAttribute(@attributeName)

    attribute.set(value: $input.val())


  # Expose the choices as an array of hashes with a value and a label.
  collectionToChoices: (collection)->
    collection.map (item)->
      value: item.get('name')
      text:  item.get('label')


  filterByBrandName: (models, brand)->
    models.filter (model)-> model.get('brandName') is brand


  fetchVehicleAttribute: (attributeName)->
    @vehicle.get('attributes').findOrCreateByName(attributeName)
