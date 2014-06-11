class Fragments.PicturesItem extends Backbone.Marionette.ItemView
  template: 'fragments/pictures/pictures_item'
  tagName: 'li'

  events:
    'click a.show-picture' : 'viewPicture'

  initialize: ({@modelCollection})->
    @setBindings()

  setBindings: ->
    @bindTo @model, 'change:title', @render
    @bindTo @model, 'change:comments_size', @render
    @bindTo @model, 'change:thumb_url', @render

  onRender: ->
    @$el.attr('id', 'thumbnail_' + @model.id)

  viewPicture: ->
    MyApp.vent.trigger 'check:pictures:order', @model
    MyApp.modal.show new Pages.Pictures.Show
      picture: @model
      pictures: @modelCollection
    false

  serializeData: ->
    picture: @model
