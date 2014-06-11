json.array! @news_feeds do |json, news_feed|
  json.partial! 'news_feed', news_feed: news_feed
end