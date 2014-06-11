class Picture < ActiveRecord::Base
  attr_accessible :title, :created_at, :image, :media_type, :video_id
  mount_uploader :image, PictureImageUploader

  has_many :comments, dependent: :destroy
  has_many :cutouts
  has_many :news_feeds, as: :target, dependent: :destroy

  belongs_to :gallery

  after_destroy :destroy_grouped_gallery_news_feeds

  delegate :vehicle, :version, :to => :gallery

  class_attribute :news_feed_group_instance_class
  self.news_feed_group_instance_class = Comment

  def user
    raise NotImplementedError
  end

  def image_thumb_url
    self.image.thumb.url && self.image.thumb.url + "?r=#{self.image_revision}"
  end

  def image_alt
    "#{gallery.try :cover_picture_alt}##{(self.image.url || '').split('/').last}"
  end

  def comments_size_visible_by other_user
    other_user || other_user = User.new
    self.comments_visible_by(other_user).size
  end

  def comments_visible_by other_user
    other_user || other_user = User.new
    self.comments.joins { user }.where { user.id.not_in my{other_user.opposer_ids} }.order('comments.id ASC')
  end

  def media_content_url
    if self.media_type == 'youtube'
      #TODO: code duplicates Models.Cutout::youTubeSource and Cutout
      query_string = '?rel=0'
      'http://www.youtube.com/embed/' + self.video_id + query_string
    else
      self.image.big.url && self.image.big.url + "?r=#{self.image_revision}"
    end
  end

  def media_content_width
    if self.media_type == 'youtube'
      640
    else
      self.image_big_width
    end
  end

  def media_content_height
    if self.media_type == 'youtube'
      390
    else
      self.image_big_height
    end
  end

  # 12x5 on newsfeed for SINGLE images
  # 16x9 on newsfeed for gallery creation images
  def news_feed_extra(news_feed, image_type = :twelve_x_5)
    extra = {
      image_url:  image.send(image_type).url,
      image_alt:  image_alt,
      gallery_id: gallery_id,
      vehicle_id: gallery.try(:vehicle_id)
    }
    if news_feed.event_type == 'add_comments_to_picture'
      u = user
      extra.merge!({
        :comments => news_feed.group_instances.each { |comment| comment.news_feed_extra(news_feed) },
        :commentable_owner_avatar_url => u.avatar_url,
        :commentable_owner_username => u.username,
        :commentable_owner_id => u.id
      })
    end
    extra
  end

  private

  def destroy_grouped_gallery_news_feeds
    return unless gallery
    NewsFeed.where(:event_type => 'add_pictures_to_gallery', :target_type => 'Gallery', :target_id => gallery.id).all.each do |news|
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
