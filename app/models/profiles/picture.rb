class Profiles::Picture < Picture
  attr_accessible :remote_image_url, :profile_id, :gallery_id
  belongs_to :profile, class_name: User

  has_one :covered_album, class_name: Album, foreign_key: 'cover_picture_id'

  delegate :user, to: :profile
end
