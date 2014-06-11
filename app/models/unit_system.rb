class UnitSystem
  attr_reader :name, :label, :units

  DEFAULT = 'EU'

  #TODO: remove all code except ::units_for along with json.systemOfUnits
  def self.units_for(system =  DEFAULT)
    units = Settings.unit_kinds.each_with_object({}) do |(kind, unit), obj|
      convertable = unit[system]
      obj[kind] = convertable ? convertable['name'] : unit['name']
    end
    { name: system, label: system, units: units }
  end

  def self.all
    [ UnitSystem::EU, UnitSystem::UK, UnitSystem::US ]
  end

  def initialize(name, units)
    @name  = name
    @label = name
    @units = units
  end

  def unit_for(type)
    @units[type] or raise UnitSystem::UnknownUnitType
  end

  class UnknownUnitType < StandardError; end
end

UnitSystem::EU = UnitSystem.new(UnitSystem::DEFAULT, {
  electric_power:    :kilowatt,
  power:             :horsepower_eu,
  torque:            :newton_metre,
  speed:             :kilometre_per_hour,
  volume:            :litre,
  displacement:      :cubic_centimetre,
  little_volume:     :cubic_centimetre,
  weight:            :kilogram,
  fuel_consumption:  :litres_per_100_kilometres,
  distance:          :kilometre,
  pressure:          :bar,
  length:            :millimetre,
  gas_emissions:     :gram_per_kilometre,
  energy:            :kilowatt_hour,
  duration:          :hour,
  autonomy_distance: :kilometre,
  electric_charge:   :ampere_hour,
  short_duration:    :second,
  short_distance:    :metre,
  currency:          :euro
})

UnitSystem::UK = UnitSystem.new('UK', {
  electric_power:    :kilowatt,
  power:             :horsepower_uk,
  torque:            :foot_pounds,
  speed:             :mile_per_hour,
  volume:            :imperial_gallon,
  displacement:      :cubic_centimetre,
  little_volume:     :cubic_centimetre,
  weight:            :pound,
  fuel_consumption:  :miles_per_imperial_gallon,
  distance:          :mile,
  pressure:          :pound_per_square_inch,
  length:            :inch,
  gas_emissions:     :gram_per_mile,
  energy:            :kilowatt_hour,
  duration:          :hour,
  autonomy_distance: :mile,
  electric_charge:   :ampere_hour,
  short_duration:    :second,
  short_distance:    :foot,
  currency:          :pound
})

UnitSystem::US = UnitSystem.new('US', {
  electric_power:    :kilowatt,
  power:             :horsepower_us,
  torque:            :foot_pounds,
  speed:             :mile_per_hour,
  volume:            :us_gallon,
  displacement:      :cubic_inch,
  little_volume:     :cubic_inch,
  weight:            :pound,
  fuel_consumption:  :miles_per_us_gallon,
  distance:          :mile,
  pressure:          :pound_per_square_inch,
  length:            :inch,
  gas_emissions:     :gram_per_mile,
  energy:            :kilowatt_hour,
  duration:          :hour,
  autonomy_distance: :mile,
  electric_charge:   :ampere_hour,
  short_duration:    :second,
  short_distance:    :foot,
  currency:          :usd
})
