class Album < Gallery
  has_many :pictures, class_name: 'Profiles::Picture', dependent: :destroy, order: 'position', foreign_key: 'gallery_id'

  belongs_to :user
  belongs_to :cover_picture, class_name: 'Profiles::Picture'
end