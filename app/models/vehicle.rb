class Vehicle < ActiveRecord::Base
  attr_accessor :crop_x, :crop_y, :crop_width, :crop_height
  attr_accessible :user, :vehicle_type, :year, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :version, :brand, :model, :brand_id, :model_id, :version_id, :side_view, :side_view_id, :current_change_set_id

  belongs_to :user
  belongs_to :version
  belongs_to :side_view
  belongs_to :current_change_set, class_name: ChangeSet

  delegate :model, :body, :market_version_name, :production_code, :transmission_type, to: :version
  delegate :brand, to: :model

  has_one :ownership, dependent: :destroy
  has_one :collage, class_name: 'DefaultVehicleCollage', foreign_key: 'vehicle_id', dependent: :destroy

  has_many :part_purchases, dependent: :destroy
  has_many :modifications, dependent: :destroy
  has_many :change_sets, dependent: :destroy
  has_many :galleries, order: 'position', dependent: :destroy
  has_many :vehicle_bookmarks, dependent: :destroy
  has_many :bookmarkers, through: :vehicle_bookmarks, source: :user, dependent: :destroy
  has_many :pictures, class_name: 'Vehicles::IdentificationPicture', foreign_key: 'vehicle_id', dependent: :destroy
  has_many :news_feeds, as: :target, dependent: :destroy

  mount_uploader :avatar, VehicleAvatarUploader

  after_save :crop_avatar
  after_create :create_default_collage

  validates_presence_of :brand, :model, :user

  AUTOMOBILE = 'automobile'
  MOTORCYCLE = 'motorcycle'
  TYPES = [AUTOMOBILE, MOTORCYCLE]
  assignable_values_for(:vehicle_type) { TYPES }

  scope :approved, joins(:version).where(version: {status: Version::APPROVED.to_s})
  scope :not_approved, joins(:version).where { version.status != Version::APPROVED.to_s }
  scope :with_model, lambda {|model| joins(version: :model).where(version: {model_id: model.id})}

  alias default_collage collage

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def auto?
    vehicle_type == AUTOMOBILE
  end
  alias automobile? auto?

  def moto?
    vehicle_type == MOTORCYCLE
  end
  alias motorcycle? moto?

  def keywords
    %W( general motor-vehicle #{vehicle_type} )
  end

  def has_body?
    vehicle_type == 'automobile'
  end

  def can_create_news_feed?
    version.status == Version::APPROVED.to_s && avatar.present? && side_view.present?
  end

  def news_feed_extra(news_feed)
    {
      :vehicle_type => vehicle_type,
      :thumbnail_url => avatar.twelve_x_5.url,
      :vehicle_id => id,
      :version_label => version.full_label
    }
  end

  protected

  def create_default_collage
    collage = DefaultVehicleCollage.new
    collage.vehicle_id = id
    collage.save
  end
end
