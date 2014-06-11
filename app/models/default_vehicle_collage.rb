class DefaultVehicleCollage < Collage
  belongs_to :vehicle
  validates :vehicle_id, uniqueness: true

  before_save :set_layout

  delegate :user, to: :vehicle

  LAYOUT = 'layout-14'

  def cutouts_with_placeholders
    cutouts_with_placeholders_of(active_layout)
  end

  protected

  def set_layout
    self.active_layout = LAYOUT
  end
end
