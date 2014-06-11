Modals.Vehicles.AddCategory = Backbone.Marionette.ItemView.extend
  template:   'modals/vehicles/add_category'
  categories: []

  events:
    'click a' : 'chooseCategory'


  initialize: ->
    amplify.request 'categories.all', (categories)=>
      @categories = categories
      @render()


  chooseCategory: (event)->
    $link    = $(event.target)
    name     = $link.data('category')
    category = _.find(@categories, (category)-> category.name == name)

    @model.get('specifications').add(category)
    @close()
    false


  serializeData: ->
    categories: @unusedCategories()


  unusedCategories: ->
    usedNames = @model.get('specifications').pluck('name')
    _.reject(@categories, (category)=> _.include(usedNames, category.name))
