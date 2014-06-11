//=require ./index_item
Fragments.Breadcrumb.Index = Backbone.Marionette.CollectionView.extend
  itemView  : Fragments.Breadcrumb.IndexItem
  tagName   : 'ul'
