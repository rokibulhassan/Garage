# TODO: put most of this in module, duplicates code for models/profiles/picture
class Vehicles::IdentificationPicture < Picture
  attr_accessible :position, :covered_gallery, :rotate, :blur, :unblur
  attr_accessor :rotate, :blur, :unblur
  serialize :image_blur_areas, Array

  belongs_to :vehicle
  delegate :user, :to => :vehicle

  validates_inclusion_of :rotate, :in => %w( right left ), :allow_nil => true

  def image_blur_areas
    attributes['image_blur_areas'] ||= []
  end
end
