class GlobalSelectOption < ActiveRecord::Base
  validates :vehicle_type, :inclusion => { :in => Vehicle::TYPES }
  validates :name, :uniqueness => { :scope => :vehicle_type }

  serialize :options, JSON

  attr_accessible :vehicle_type, :name, :options

  ALIASES = {
    Vehicle::AUTOMOBILE => {
      :body => 'body',
      :transmission_numbers => 'gearbox speeds',
      :transmission_type => 'gearbox type',
      :transmission_details => 'transmission'
    },
    Vehicle::MOTORCYCLE => {
      :body => 'category',
      :transmission_numbers => 'gearbox speeds',
      :transmission_type => 'gearbox type',
      :transmission_details => 'transmission'
    }
  }

  def self.for_cars
    where(:vehicle_type => Vehicle::AUTOMOBILE)
  end

  def self.for_bikes
    where(:vehicle_type => Vehicle::MOTORCYCLE)
  end

  def options
    self.options = read_attribute(:options) || {}
  end

  # for activeadmin form
  def options_en
    (options['en'] || []).join("\n")
  end

  def options_fr
    (options['fr'] || []).join("\n")
  end
end
