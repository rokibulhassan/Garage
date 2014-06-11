AvailableItems = Backbone.Marionette.ItemView.extend
  template: 'modals/vehicles/available_items'

  initialize: (attributes)->
    @items = attributes.items


  serializeData: ->
    items: @items



EditItem = Backbone.Marionette.ItemView.extend
  template: 'modals/vehicles/edit_item'

  events:
    'submit form' : 'addItemToVehicle'


  # @item is a plain old object describing the specifications item.
  # @category is a category object for the vehicle.
  initialize: (attributes)->
    @item     = attributes.item
    @category = attributes.category


  addItemToVehicle: (event)->
    $form = $(event.target)
    item  = @buildItem($form)

    @category.get('items').add(item)
    MyApp.modal.currentView.close()
    false


  buildItem: ($form)->
    switch @item.type
      when 'numeric_integer', 'numeric_decimal_with_unit'
        $input = $form.find('input')
        @item.value = $input.val()

      when 'static_choice'
        $select = $form.find('select')
        @item.value = $select.val()

      else
        throw "Don't know how to deal with #{@item.type}!"

    @item


  onRender: ->
    callback = =>
      @$('input').focus() if @$('input').length
      @$('select').focus() if @$('select').length

    setTimeout(callback, 1)


  serializeData: ->
    item: @item



Modals.Vehicles.AddItem = Backbone.Marionette.Layout.extend
  template: 'modals/vehicles/add_item'

  regions:
    content: '.content'

  events:
    'click a' : 'chooseItem'


  # @category is a Category object, children of a Vehicle object.
  # @items is an array of plain old objects.
  initialize: (attributes)->
    @category = attributes.category
    @items    = attributes.items


  chooseItem: (event)->
    $link = $(event.target)
    name  = $link.data('item')
    item  = _.find(@items, (item)-> item.name == name)

    @content.show(new EditItem(item: item, category: @category))
    false


  onRender: ->
    @content.show(new AvailableItems(items: @availableItems()))


  serializeData: ->
    items: @items


  availableItems: ->
    usedNames = @category.get('items').pluck('name')
    _.reject(@items, ((item)=> _.include(usedNames, item.name)))
