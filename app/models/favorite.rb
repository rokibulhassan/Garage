class Favorite < ActiveRecord::Base
  attr_accessible :label, :url, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :image, :page_url

  belongs_to :user

  # TODO: change to carrierwave if this is actually being used (luke)
  has_attached_file :image, styles: { thumbnail: '220x140' }
end
