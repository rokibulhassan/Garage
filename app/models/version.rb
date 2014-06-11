class Version < ActiveRecord::Base
  UNAPPROVED, APPROVED, PENDING = :unapproved, :approved, :pending
  STATUSES = [UNAPPROVED, APPROVED, PENDING]

  include Transliterate

  attr_accessible :label_en, :label_fr, :name, :second_name, :model_id, :production_year,
    :generation, :generation_attributes, :production_code, :body, :transmission_numbers,
    :transmission_type, :market_version_name, :doors, :energy, :transmission_details,
    :show_model_name

  #TODO: remove this shit and traco in favor of gettext_i18n_rails.
  translates :label

  transliterate :body, :transmission_type, :transmission_numbers

  validates :production_year, inclusion: { in: lambda { |_| 1900..Time.current.year + 1 } }, allow_nil: true

  belongs_to :model
  has_one :generation, dependent: :destroy
  has_many :vehicles
  has_many :prewritten_comments, class_name: 'PrewrittenVersionComment', :through => :prewritten_comments_version_user, :source => :prewritten_comment
  has_many :prewritten_comments_version_user, dependent: :destroy
  has_many :side_views
  has_many :properties, class_name: 'VersionProperty', include: :property_definition do
    def find_by_name name
      joins(:property_definition).where(property_definitions: { name: name }).first
    end
  end

  delegate :vehicle_type, :to => :model

  accepts_nested_attributes_for :generation

  scope :approved, where(status: APPROVED.to_s)
  # NOTE: version should really belong_to a vehicle... I don't know why this
  # is not the case. In order to touch the related vehicle, this is the only
  # option with the current way that the models relate to each other
  after_update :touch_vehicles

  state_machine :status, initial: UNAPPROVED do
    event :approve do
      transition any => APPROVED
    end
    event :unapprove do
      transition any => UNAPPROVED
    end
  end

  def self.value_set_of attribute_name
    self.where("versions.#{attribute_name} IS NOT NULL").uniq.pluck(attribute_name)
  end

  def data_sheet_props
    data_sheet_all_props.merge! data_sheet_defined_props
  end

  def comparison_props
    names = ComparisonTable.comparison_attribute_names
    data_sheet_all_props(names).merge! data_sheet_defined_props(names)
  end

  # treat nil as true
  def show_model_name
    read_attribute(:show_model_name) != false
  end

  def data_sheet_defined_props property_definition_names = []
    props = self.properties
    props = props.where property_definition: {name: property_definition_names} if property_definition_names.any?

    res = {}
    props.each do |obj|
      res[obj.name] = obj
    end
    res
  end

  def data_sheet_all_props property_definition_names = []
    props = property_definition_names.any? ? PropertyDefinition.where(name: property_definition_names) : PropertyDefinition.all

    res = {}
    props.each do |obj|
      property = VersionProperty.new(property_definition_id: obj.id, version_id: self.id)
      property.name = obj.name
      res[obj.name] = property
    end
    res
  end

  # @returns HASH(STRING => ARRAY)
  # { 'doors' => [1,2,3,4], 'transmission_types' => [...] }
  def global_select_options attrs = [], locale = 'en'
    selects = GlobalSelectOption.where(:vehicle_type => vehicle_type).all
    names_with_options = {}
    selects.each { |s| names_with_options[s.name] = s.options[locale.to_s] }
    attrs.each do |attr|
      names_with_options[attr] ||= []
    end
    names_with_options
  end

  # @returns HASH(STRING => HASH(STRING => STRING))
  # { 'energy' => {'gas' => 'pétrol', 'diesel' => 'diesel'}}
  def global_select_options_translations(select_options)
    english_global_options = select_options['en']
    locale_global_options = select_options.except('en').values.first
    ret = {}

    english_global_options.each do |name, vals|
      next if vals.nil?
      ret[name] = {}
      vals.each_with_index do |val, i|
        ret[name][val] = locale_global_options[name][i]
      end
    end

    ret
  end

  def comment_by_user(user)
    prewritten_comments_version_user.where(:user_id => user.id).first.try(:prewritten_comment)
  end

  def random_user_comments
    prewritten_comments_version_user.order('random()')
  end

  def random_user_comment_as_json
    random = random_user_comments
    count = random.count
    comment = random.limit(1000).first
    return if comment.blank?
    {
      comment: comment.prewritten_comment,
      amt_comments: count,
      user_avatar_url: comment.user.avatar_url,
      user_id: comment.user_id
    }
  end

  def comments_as_json
    res = []
    prewritten_comments_version_user.order('id ASC').limit(100).each do |user_comment|
      res << comment_as_json(user_comment)
    end
    res
  end

  def comment_as_json(user_comment)
    {
      comment: user_comment.prewritten_comment,
      id: user_comment.prewritten_comment.id,
      version_id: user_comment.version_id,
      commenter: {
        avatar_url: user_comment.user.avatar_url,
        username: user_comment.user.username,
        id: user_comment.user_id
      }
    }
  end

  def full_label
    "#{self.model.try(:full_label)} #{self.label}"
  end

  def vehicle
    vehicles.first
  end

  def user
    logger.error "ERROR: There's more than 1 vehicle for version #{id}" if vehicles.size > 1
    vehicle.try(:user)
  end

  def extended_label
    "#{self.model.full_label} #{self.body} - #{self.generation.label} [#{self.production_code}]"
  end

  alias news_feed_items_showable? approved?

  def touch_vehicles
    vehicles.each(&:touch)
  end

end
