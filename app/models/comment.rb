class Comment < ActiveRecord::Base
  attr_accessible :body

  has_many :news_feeds, as: :target, dependent: :destroy

  belongs_to :user
  belongs_to :picture

  delegate :version, to: 'picture.gallery'

  after_destroy :destroy_grouped_comment_picture_news_feeds

  def edited?
    self.updated_at > self.created_at
  end

  def recent?
    self.created_at > 7.days.ago
  end

  def commented_on
    picture_id.presence ? 'picture' : 'unknown'
  end

  def news_feed_group_target
    picture
  end

  def news_feed_extra(news_feed)
    comment_cropped_length = 37
    extra = {
        comment: self.body.length > comment_cropped_length ? "#{self.body.first(comment_cropped_length)}..." : self.body,
        commented_on: commented_on
    }
    extra
  end

  def destroy_grouped_comment_picture_news_feeds
    return unless picture
    NewsFeed.where(:event_type => 'add_comments_to_picture', :target_type => 'Picture', :target_id => picture.id).all.each do |news|
      if news.child_ids.include?(id)
        news.child_ids.delete_if { |child_id| child_id.to_i == id.to_i }
        if news.child_ids.blank?
          news.destroy
        else
          news.save
        end
      end
    end
  end

end
