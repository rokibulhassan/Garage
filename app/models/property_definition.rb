class PropertyDefinition < ActiveRecord::Base
  attr_accessible :name, :unit_type

  has_many :version_properties
  has_many :modification_properties

  #TODO: validate :unit - e.g. Unit('cm^3') should not raise exception

  def self.for system_of_units = UnitSystem::DEFAULT
    PropertyDefinition.all.inject({}) do |acc, definition|
      unit_type_def = Settings.unit_kinds[definition.unit_type]
      acc[definition.name] = unit_type_def['name'] || unit_type_def[system_of_units]['name']

      acc
    end
  end

  def unit system_of_units = UnitSystem::DEFAULT
    unit_type_def = Settings.unit_kinds[self.unit_type]
    unit_type_def['unit'] || unit_type_def[system_of_units]['unit']
  end

  def inverse? system_of_units = UnitSystem::DEFAULT
    unit_type_def = Settings.unit_kinds[self.unit_type]
    unit_type_def[system_of_units] ? unit_type_def[system_of_units].keys.include?('inverse') : false
  end
end
