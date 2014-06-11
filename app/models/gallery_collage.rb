class GalleryCollage < Collage
  belongs_to :gallery
  acts_as_list scope: :gallery

  before_validation :check_layout

  protected
  def check_layout
    if active_layout == DefaultVehicleCollage::LAYOUT
      errors.add(:active_layout, "can't be #{DefaultVehicleCollage::LAYOUT}")
    end
  end
end
