class Collections.NewsFeeds extends Backbone.Collection
  model: Models.NewsFeed

  url: ->
    "/api/news_feeds"

  # make sure gallery creation event items are shown before new comment
  # creation event items which are shown before vehicle creation event items,
  # if all have the same updated_at time
  comparator: (newsItem) ->
    updatedAt = new Date(newsItem.get('updated_at'))
    eventType = newsItem.get('event_type')
    if eventType is 'create_gallery'
      updatedAt.setTime(updatedAt.getTime() + 1000)
    else if eventType is 'add_comments_to_picture'
      updatedAt.setTime(updatedAt.getTime() + 500)
    -updatedAt

