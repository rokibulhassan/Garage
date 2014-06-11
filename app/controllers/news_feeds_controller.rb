class NewsFeedsController < ApplicationController
  def index
    @news_feeds = NewsFeedSearch.new(params[:my] ? current_user : nil, page: params[:page]).news_feeds
  end
end
