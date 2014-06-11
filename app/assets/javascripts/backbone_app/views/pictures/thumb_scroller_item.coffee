Fragments.Pictures.ThumbScrollerItem = Backbone.Marionette.ItemView.extend
  template: 'fragments/pictures/thumb_scroller_item'
  tagName: 'div'


  initialize: (options)->
    @isCurrent = 'current' if @model == options.currentPicture


  events:
    'click a.show-picture' : 'viewPicture'


  serializeData: ->
    picture: @model
    isCurrent: @isCurrent


  viewPicture: ->
    MyApp.vent.trigger('picture:jump:to', @model)
    false
