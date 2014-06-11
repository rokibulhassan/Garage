#= require ./pictures_item

class Fragments.Pictures extends Backbone.Marionette.CompositeView
  template: 'fragments/pictures/pictures'
  itemView: Fragments.PicturesItem

  initialize: ({@canManage})->

  itemViewOptions: ->
    modelCollection: @collection


  appendHtml: (collectionView, itemView)->
    collectionView.$('ul.thumbnails').prepend(itemView.el)
