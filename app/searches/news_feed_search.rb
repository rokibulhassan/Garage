class NewsFeedSearch
  PER_PAGE_LIMIT = 20

  def initialize user, opts = {}
    @user     = user
    @per_page = opts[:per_page] || PER_PAGE_LIMIT
    @page     = (opts[:page] || 1).to_i
  end

  def news_feeds
    basic_relation.limit(@per_page).offset((@page - 1) * @per_page)
  end

  private

  def basic_relation
    relation = if @user.present?
        @user.news_feeds.visible.includes(:target).order('updated_at').reverse_order
      else
        distinct_query = "DATE_TRUNC('minute', news_feeds.updated_at), news_feeds.initiator_id, news_feeds.target_id, news_feeds.target_type, news_feeds.event_type"
        order_query    = "DATE_TRUNC('minute', news_feeds.updated_at) DESC, news_feeds.initiator_id, news_feeds.target_id, news_feeds.target_type, news_feeds.event_type"
        NewsFeed.select("DISTINCT ON (#{distinct_query}) news_feeds.*").visible.order(order_query)
      end

    relation.includes(:initiator).
        joins("LEFT JOIN pictures ON news_feeds.target_id = pictures.id AND news_feeds.target_type = 'Picture'").
        joins("LEFT JOIN part_purchases ON news_feeds.target_id = part_purchases.id AND news_feeds.target_type = 'PartPurchase'").
        joins("LEFT JOIN comments ON news_feeds.target_id = comments.id AND news_feeds.target_type = 'Comment'").
        joins("LEFT JOIN modifications ON news_feeds.target_id = modifications.id AND news_feeds.target_type = 'Modification'").
        joins("LEFT JOIN galleries ON news_feeds.target_id = galleries.id AND news_feeds.target_type = 'Gallery'")
  end
end
