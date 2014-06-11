//= require ./cutouts_item
Fragments.Collages.Cutouts = Backbone.Marionette.CollectionView.extend
  tagName  : 'ul'
  itemView : Fragments.Collages.CutoutsItem


  initialize: (attributes)->
    @itemViewOptions = =>
      modeEdit: attributes.modeEdit
