json.id          news_feed.id
json.event_type  news_feed.event_type
json.updated_at  news_feed.updated_at.strftime('%Y-%m-%d %H:%M')

if comp_vehicles = news_feed.target.news_feed_extra(news_feed).delete(:comparison_vehicles)
  json.vehicles(comp_vehicles) do |json, vehicle|
    json.partial!('vehicle', vehicle: VehicleDecorator.new(vehicle))
  end
end

json.target do |json|
  json.id   news_feed.target_id
  json.type news_feed.target_type
  json.extra do |json|
    news_feed.target.news_feed_extra(news_feed).each do |key, value|
      json.set! key, value
    end
  end
end

json.listener do |json|
  json.id news_feed.listener_id
end

json.initiator do |json|
  json.id           news_feed.initiator_id
  json.username     news_feed.initiator.username
  json.avatar_url   news_feed.initiator.avatar_url
end
