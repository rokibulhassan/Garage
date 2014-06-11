#= require './news_feeds_item_layout'

class Pages.Dashboard.NewsFeeds extends Backbone.Marionette.CollectionView
  itemView: Pages.Dashboard.NewsFeedsItemLayout
  tagName: 'ul'

  initialize: ({@collection}) ->
    @collection.models = @collection.filter (model) ->
      if model.get('event_type') is 'create_comparison_table'
        vehiclesWithSideViews = model.get('vehicles').filter (v) ->
          not v.hasDefaultSideView()
        vehiclesWithSideViews.length isnt 0
      else
        true
