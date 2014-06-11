class ProfileCollage < Collage
  belongs_to :profile, class_name: User
  acts_as_list scope: :profile

  before_validation :check_layout

  protected
  def check_layout
    if active_layout == DefaultVehicleCollage::LAYOUT
      errors.add(:active_layout, "can't be #{DefaultVehicleCollage::LAYOUT}")
    end
  end
end
