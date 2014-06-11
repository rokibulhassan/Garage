class SideView < ActiveRecord::Base
  attr_protected [], as: :admin_user
  serialize :image_dimensions, JSON

  has_many :vehicles
  belongs_to :version

  scope :same_to, lambda { |version| joins(version: :generation).where(version: {model_id: version.model_id, body: version.body }) }

  before_save :save_image_dimensions

  mount_uploader :image, SideViewImageUploader

  def image=(new_file)
    @new_file = new_file
  end

  def version_id= version_id
    write_attribute :version_id, version_id
    _mounter(:image).cache @new_file
  end

  # @returns HASH
  # {:thumb=>/system/uploads/side_view/image/8/thumb_side_view.jpeg, :large=>/system/uploads/side_view/image/8/large_side_view.jpeg} 
  def images
    image.versions
  end

  def image_dimensions
    self.image_dimensions = (read_attribute(:image_dimensions) || {})
  end

  private

  def save_image_dimensions
    if image_changed? || new_record?
      image.versions.keys.each do |img_version|
        self.image_dimensions[img_version] ||= {}
        self.image_dimensions[img_version][:width]  = image.send(img_version).geometry[:width]
        self.image_dimensions[img_version][:height] = image.send(img_version).geometry[:height]
      end
    end
  end
end
