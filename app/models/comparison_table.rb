class ComparisonTable < ActiveRecord::Base
  attr_accessible :label, :vehicle_ids, :selected_change_set_ids

  serialize :selected_change_set_ids, JSON

  belongs_to :user
  has_many :comparison_table_vehicles
  has_many :vehicles, through: :comparison_table_vehicles
  has_many :likes, :as => :likeable
  has_many :news_feeds, :as => :target, :dependent => :destroy

  validates_presence_of :user
  validates :save_id, :uniqueness => {:scope => :user_id}, :if => lambda { |comp| comp.save_id.present? }
  validate :approved_vehicles

  PERFORMANCE_ATTRIBUTES = [:top_speed, :accel_time_0_100_kph, :accel_time_100_200_kph, :time_on_402]
  CONSUMPTION_ATTRIBUTES = [:consumption_city, :consumption_highway, :consumption_mixed, :CO2_emissions]
  SPECIFICATIONS_ATTRIBUTES = [:displacement, :max_power, :max_torque, :weight]
  COSTS_ATTRIBUTES = []

  COMPARISON_ATTRIBUTES = {
      performance: PERFORMANCE_ATTRIBUTES,
      consumption: CONSUMPTION_ATTRIBUTES,
      specifications: SPECIFICATIONS_ATTRIBUTES,
      costs: COSTS_ATTRIBUTES
  }

  def self.comparison_attribute_names
    @comparison_attribute_names ||= ComparisonTable::COMPARISON_ATTRIBUTES.values.flatten.map &:to_s
  end

  def self.recent(limit = 3)
    limit(limit).order('created_at DESC')
  end

  def inject_comparison_property_values_for user

    property_values = ComparisonTable.comparison_attribute_names.inject({}) do |acc, attribute|
      acc[attribute.to_s] = {max_value: 0, property_values: []}
      acc
    end

    vehicles.each do |vehicle|
      spec_props_hash = vehicle.version.data_sheet_defined_props ComparisonTable.comparison_attribute_names
      vehicle.change_sets.each do |change_set|
        change_set_properties_hash = change_set.comparison_properties
        spec_props_hash.each do |attribute, property|
          value = property.value_added_and_decorated_for change_set_properties_hash[attribute], user

          # Some shit we have to do to display inverse bars for accel_time_0_100_kph
          normalized_value = if attribute == "accel_time_0_100_kph"
                               value.zero? ? 0 : 100.0 / value
                             else
                               value
                             end.try(:round, 2)

          property_values[property.name][:max_value] = normalized_value.to_f if normalized_value.to_f > property_values[property.name][:max_value]
          property_values[property.name][:property_values] << { change_set_id: change_set.id,
                                                                change_set_name: change_set.name,
                                                                property_value:  value,
                                                                normalized_value: normalized_value.to_f,
                                                                side_view_url: vehicle.side_view && vehicle.side_view.image.thumb.url,
                                                                vehicle_type: vehicle.vehicle_type,
                                                                vehicle_id: vehicle.id
                                                              }
        end
      end
    end


    property_values.each do |attribute, hash|
      hash[:property_values].sort! {|values1, values2| values2[:normalized_value] <=> values1[:normalized_value]}
    end
  end

  def saves
    ComparisonTable.where(:save_id => id)
  end

  def news_feed_extra(news_feed)
    comparison = ComparisonTable.includes(:vehicles => [:version, :side_view, :part_purchases]).where(
      :comparison_tables => { :id => id }
    ).first
    return {} if comparison.blank?
    vehicles = comparison.vehicles
    hps = {}
    vehicles.each do |v|
      vprop = v.version.properties.find_by_name('max_power')
      if User.current.blank? || vprop.blank?
        hps[v.id] = v.version.properties.find_by_name('max_power').try(:value)
      elsif User.current.present? && vprop.present?
        hps[v.id] = v.version.properties.find_by_name('max_power').value_object(User.current.system_of_units_code).try(:scalar)
      else
        hps[v.id] = nil
      end
    end
    {
      comparison_vehicles: vehicles,
      label: label,
      hps:  hps
    }
  end

  def likers
    liker_ids = Like.where(:likeable_type => self.class.name, :likeable_id => id).all.map(&:user_id)
    User.where(:id => liker_ids)
  end

  def savers
    saver_ids = ComparisonTable.where(:save_id => id).all.map(&:user_id)
    User.where(:id => saver_ids)
  end

  private

  def approved_vehicles
    errors.add("vehicles", "can't include unapproved instances") if vehicles.any? {|vehicle| !vehicle.version.approved?}
  end

end
