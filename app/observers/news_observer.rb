class NewsObserver < ActiveRecord::Observer
  observe :gallery, :modification, :part_purchase, :picture, :comment, :comparison_table, :vehicle

  def after_create observable
    obs_class = observable.class
    initiator = obs_class == Comment ? observable.picture.user : observable.user

    grouped_event = NewsFeed::GROUPED_TYPES[obs_class]
    single_event = NewsFeed::TYPES[obs_class]
    # hide these news events if the vehicle is not approved, until associated vehicle is approved
    if obs_class.in?(NewsFeed::SHOW_ON_VEHICLE_APPROVED_TYPES)
      wait_on = observable.version
      hidden = !wait_on.news_feed_items_showable?
    else
      wait_on = nil
      hidden = false
    end

    if grouped_event
      if (news_feeds = grouped_news_feeds(observable.news_feed_group_target, grouped_event)).any?
        news_feeds.each do |news|
          news.child_ids << observable.id
          news.save
        end
      else
        create_all_news_feeds(initiator, observable.news_feed_group_target, grouped_event, [observable.id], wait_on, hidden)
      end
    elsif single_event
      create_all_news_feeds(initiator, observable, single_event, nil, wait_on, hidden)
    end
  end

  private

  def create_all_news_feeds(initiator, target, event_type, child_ids, wait_on, hidden)
    Following.all_by_thing(initiator).each do |following|
      NewsFeed.create listener: following.user,
                      initiator: initiator,
                      target: target,
                      event_type: event_type,
                      child_ids: child_ids,
                      wait_on: wait_on,
                      hidden: hidden
    end
    # and make sure to create one for the initiator as listener
    NewsFeed.create listener: initiator,
                    initiator: initiator,
                    target: target,
                    event_type: event_type,
                    child_ids: child_ids,
                    wait_on: wait_on,
                    hidden: hidden
  end

  def grouped_news_feeds(target, event_type)
    scope = NewsFeed.where(:target_id => target.id, :event_type => event_type)
  end
end
