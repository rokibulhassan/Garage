class Galleries::Picture < Picture
  attr_accessible :position, :covered_gallery, :rotate, :blur, :unblur
  attr_accessor :rotate, :blur, :unblur
  serialize :image_blur_areas, Array

  belongs_to :gallery
  acts_as_list scope: :gallery
  has_one :covered_gallery, class_name: Gallery, :foreign_key => 'cover_picture_id'

  validates_inclusion_of :rotate, :in => %w( right left ), :allow_nil => true

  def user
    self.gallery.vehicle.user
  end

  def news_feed_group_target
    gallery
  end

  def image_blur_areas
    attributes['image_blur_areas'] ||= []
  end
end
