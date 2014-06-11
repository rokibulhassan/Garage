# This view is used to display a fieldset: a group of related form fields.
class Views.Fieldset extends Backbone.View
  className: 'well'

  initialize: (attributes)->
    @vehicle = attributes.vehicle


  render: ->
    fields   = @model.get('fields')
    $content = $(@el).empty()
    $title   = $('<h3></h3>', text: @model.get('label'))

    $content.append($title)

    fields.each (field)=>
      fieldView = new Views.Field(model: field, vehicle: @vehicle)
      $content.append(fieldView.render().el)

    @
