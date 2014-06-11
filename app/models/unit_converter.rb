class UnitConverter
  def initialize(value, from_unit)
    @value     = Float(value)
    @from_unit = from_unit
  end


  def to(to_unit)
    if @from_unit == :miles_per_imperial_gallon
      (282.48 / @value).round(2)
    elsif @from_unit == :miles_per_us_gallon
      (235.21 / @value).round(2)
    else
      factor = UnitConverter::TABLE[to_unit][@from_unit] or raise UnitConverter::UnknownConversion, "Can't convert #{@from_unit} into #{to_unit}."
      (@value * factor).round(2)
    end
  end


  TABLE = {
    # Power.
    kilowatt: {
      kilowatt:      1,     # kW
      horsepower_eu: 0.736, # hp
      horsepower_us: 0.746, # hp
      horsepower_uk: 0.746  # hp
    },
    # Torque.
    newton_metre: {
      newton_metre: 1,    # Nm
      foot_pounds:  1.356 # ft.lbs
    },
    # Speed.
    kilometre_per_hour: {
      kilometre_per_hour: 1,    # km/h
      mile_per_hour:      1.609 # mph
    },
    # Volume.
    litre: {
      litre:           1,     # L
      imperial_gallon: 4.546, # gallons
      us_gallon:       3.785  # gallons
    },
    # Displacement, little volume.
    cubic_centimetre: {
      cubic_centimetre: 1,     # cc
      cubic_inch:       16.387 # cu in
    },
    # Weight.
    kilogram: {
      kilogram: 1,      # kg
      pound:    0.45359 # lbs
    },
    # Consumption.
    litres_per_100_kilometres: {
      litres_per_100_kilometres: 1,
      miles_per_imperial_gallon: :special,
      miles_per_us_gallon:       :special
    },
    # Short distance.
    metre: {
      metre: 1, # m
      foot:  0.3048
    },
    # Distance.
    kilometre: {
      kilometre: 1,    # km
      mile:      1.609 # m
    },
    # Pressure.
    bar: {
      bar: 1,                      # bar
      pound_per_square_inch: 0.069 # psi
    },
    # Length.
    millimetre: {
      millimetre: 1, # mm
      inch:       25.4, # in
    },
    # Gas emission.
    gram_per_kilometre: {
      gram_per_kilometre: 1, #
      gram_per_mile:      1.609
    },
    # Money
    currency: {
      euro: 1.00,
      usd: 1.31,
      pound: 0.85
    }
  }


  class UnknownConversion < StandardError; end
end
