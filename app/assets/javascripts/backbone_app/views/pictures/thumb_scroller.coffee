//= require ./thumb_scroller_item
Fragments.Pictures.ThumbScroller = Backbone.Marionette.CollectionView.extend
  itemView: Fragments.Pictures.ThumbScrollerItem
  className: 'jTscroller'

  itemViewOptions: ->
    { currentPicture: @currentPicture }


  initialize: (attributes)->
    @currentPicture = attributes.currentPicture


  appendHtml: (collectionView, itemView)->
    collectionView.$el.prepend(itemView.el)


  onRender: ->
    callback = =>
      @trigger('after:render')
    setTimeout(callback, 0)
