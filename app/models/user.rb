class User < ActiveRecord::Base
  extend Mailboxer::Models::Messageable::ActiveRecord
  has_secure_password
  acts_as_messageable

  attr_accessible :email, :password, :password_confirmation, :username, :terms_of_service,
                  :first_name, :last_name, :country_code, :city, :first_name_public,
                  :last_name_public, :emailing_allowed, :locale, :currency,
                  :city_public,
                  :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at,
                  :pictures_attributes

  attr_accessor :as_admin

  validates_presence_of :password_confirmation, :password, on: :create
  validates :username, presence: true, uniqueness: true, length: 3..40

  validates_presence_of :email, unless: :facebook_id?
  validates_email_format_of :email, allow_nil: true
  validates_uniqueness_of :email

  validates_acceptance_of :terms_of_service
  validate :username_has_no_arobase

  has_many :favorites, dependent: :destroy
  has_many :galleries, :through => :vehicles
  has_many :gallery_pictures, :through => :galleries, :source => :pictures
  has_many :pictures, class_name: Profiles::Picture, foreign_key: 'profile_id', dependent: :destroy
  accepts_nested_attributes_for :pictures
  has_many :albums
  has_many :comments, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :modifications, through: :vehicles
  has_many :votes
  has_many :collages, class_name: ProfileCollage, foreign_key: 'profile_id', dependent: :destroy, order: 'position'
  has_many :vehicle_bookmarks, dependent: :destroy
  has_many :bookmarked_vehicles, through: :vehicle_bookmarks, source: :vehicle
  has_many :comparison_tables

  has_many :user_oppositions, dependent: :destroy
  has_many :opposers, through: :user_oppositions
  has_many :inverse_user_oppositions, class_name: 'UserOpposition', foreign_key: 'opposer_id'
  has_many :inverse_opposers, through: :inverse_user_oppositions, source: :user

  has_many :followings, dependent: :destroy
  has_many :news_feeds, foreign_key: :listener_id, order: :created_at, dependent: :destroy

  belongs_to :unit_system, :class_name => 'BaseUnitSystem', :foreign_key => 'unit_system_id'

  mount_uploader :avatar, UserAvatarUploader


  class << self
    attr_accessor :current
  end

  def display_name
    self.email
  end

  def mailboxer_email(object)
    nil
  end

  def property_suggestions
    PropertySuggestion.where(id: votes.where(fixable_type: 'PropertySuggestion').select(:fixable_id))
  end

  def system_of_units
    "UnitSystem::#{system_of_units_label}".constantize
  end

  def system_of_units_label
    unit_system.try(:label) || UnitSystem::DEFAULT
  end

  alias system_of_units_code system_of_units_label

  def self.with_email
    where { (email != nil) & (email != '') }
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def facebooked?
    facebook_id?
  end

  def requested_password_recovery?
    password_recovery_token?
  end

  def country
    Country.new(country_code).try(:name)
  end

  def country=(country_name)
    country = Country.find_country_by_name(country_name)
    self.country_code = country && country.alpha2
  end

  def language
    ISO_639.find(language_code)
  end

  def label
    "#{self.username}(#{self.locale}-#{self.country_code})"
  end

  def avatar_url(version = :normal)
    if read_attribute(:avatar).present?
      avatar.send(version).url
    else
      gravatar_url
    end
  end

  def gravatar_url
    return nil if email.blank?
    "http://www.gravatar.com/avatar/#{gravatar_hash}?s=100"
  end

  def language=(language_code)
    self.language_code = language_code
  end

  def pictures_count
    self.pictures.count + self.gallery_pictures.count
  end

  def save_comparison_table(comparison_table)
    return false if comparison_table.user == self
    attrs = comparison_table.attributes.symbolize_keys.except(:id, :save_id, :user_id, :created_at, :updated_at)
    comp = ComparisonTable.new(attrs)
    comp.user_id = id
    comp.save_id = comparison_table.id
    return false unless comp.save
    comp.vehicles.concat(comparison_table.vehicles)
  end

  def like_comparison_table(comparison_table)
    return false if comparison_table.user == self
    Like.like(self, comparison_table)
  end

  protected

  def username_has_no_arobase
    errors[:username] << :forbidden_arobase if username.include?('@')
  end

  def gravatar_hash
    Digest::MD5.hexdigest(email.strip.downcase)
  end
end
