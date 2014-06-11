class Gallery < ActiveRecord::Base
  attr_accessible :title, :position, :cover_picture_id, :finished, :layout, :privacy

  belongs_to :cover_picture, class_name: "Galleries::Picture"
  belongs_to :vehicle
  acts_as_list scope: :vehicle
  has_many :pictures, class_name: 'Galleries::Picture', dependent: :destroy, order: 'position'
  has_many :collages, class_name: GalleryCollage, dependent: :destroy, order: 'position'
  has_many :news_feeds, as: :target, dependent: :destroy

  validates :title, length: 3..40, allow_blank: true

  delegate :user, :version, to: :vehicle

  NO_LONGER_NEW_INTERVAL = 10.minutes

  class_attribute :news_feed_group_instance_class
  self.news_feed_group_instance_class = Galleries::Picture

  def self.finished
    where(finished: true)
  end

  def cover_picture_url
    cover_picture.try(:image_thumb_url)
  end

  def cover_picture_alt(cover_picture = self.cover_picture)
    cover_picture.try(:title)
  end

  def news_feed_extra(news_feed)
    if news_feed.event_type == 'create_gallery'
      create_gallery_news_feed_extra(news_feed)
    elsif news_feed.event_type == 'add_pictures_to_gallery'
      add_pictures_to_gallery_news_feed_extra(news_feed)
    else
      raise ArgumentError, "unexpected event type: #{news_feed.event_type}"
    end
  end

  private

  def create_gallery_news_feed_extra(news_feed)
    pics = self.pictures.first 3
    {
      cover_picture_url: self.cover_picture.try(:image).try(:sixteen_x_9).try(:url),
      cover_picture_alt: cover_picture_alt,
      gallery_id:        self.id,
      vehicle_id:        self.vehicle_id,
      title:             title,
      pictures_extra:    pics.map { |pic| pic.news_feed_extra(news_feed, :sixteen_x_9_small) }
    }
  end

  def add_pictures_to_gallery_news_feed_extra(news_feed)
    cover_pic, *pics = news_feed.group_instances.first(4)
    return {} if cover_pic.blank?
    {
      cover_picture_url: cover_pic.image.sixteen_x_9.url,
      cover_picture_alt: cover_picture_alt(cover_pic),
      gallery_id:        self.id,
      vehicle_id:        self.vehicle_id,
      title:             title,
      pictures_extra:    pics.map { |pic| pic.news_feed_extra(news_feed, :sixteen_x_9_small) }
    }
  end
end
