class Models.UnitConverter
  table:
    kilowatt:
      kilowatt:      1
      horsepower_eu: 1 / 0.736
      horsepower_uk: 1 / 0.746
      horsepower_us: 1 / 0.746

    newton_metre:
      newton_metre: 1
      foot_pounds:  1 / 1.356

    cubic_centimetre:
      cubic_centimetre: 1
      cubic_inch:       1 / 16.387

    kilometre:
      kilometre: 1
      mile: 1 / 1.609

    millimetre:
      millimetre: 1
      inch: 1 / 25.4

    kilowatt_hour:
      kilowatt_hour: 1

    hour:
      hour: 1

    gram_per_kilometre:
      gram_per_kilometre: 1
      gram_per_mile: 1.609

    ampere_hour:
      ampere_hour: 1

    kilometre_per_hour:
      kilometre_per_hour: 1
      mile_per_hour: 1 / 1.609

    litres_per_100_kilometres:
      litres_per_100_kilometres: 1

    metre:
      metre: 1
      foot:  1 / 0.3048

    second:
      second: 1


  constructor: (value, @fromUnit)->
    @value = parseFloat(value)


  to: (toUnit)->
    return null unless @value

    try
      if toUnit == 'miles_per_imperial_gallon'
        282.48 / @value
      else if toUnit == 'miles_per_us_gallon'
        235.21 / @value
      else
        @table[@fromUnit] || throw 'Error'
        @table[@fromUnit][toUnit] || throw 'Error'

        @value * @table[@fromUnit][toUnit]

    catch error
      throw "Can't convert #{@fromUnit} into #{toUnit}."


  toConversion: (toUnit, precision = 1)->
    fromValue: @value
    toValue:   @to(toUnit).round(precision)
    fromUnit:  @fromUnit
    toUnit:    toUnit
