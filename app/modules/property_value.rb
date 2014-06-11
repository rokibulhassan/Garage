module PropertyValue
  attr_accessor :actor

  def with_units?
    self.property_definition.unit && attributes['value']
  end

  def value_object system_of_units = UnitSystem::DEFAULT
    if with_units?
      result = Unit("#{attributes['value']} #{self.property_definition.unit}")
        .to(self.property_definition.unit(system_of_units))
      #FIXME: in fact, it supports only 'fuel_consumption' unit_type in the '(property_definition.inverse? and differential?)' branch
      if self.property_definition.inverse?(system_of_units)
        if differential?
          k = normalization_coeff system_of_units
          ef = normalization_base
          delta_ef = Unit("#{attributes['value']} #{self.property_definition.unit}").scalar
          delta_ex = - (k * delta_ef) / ((ef ** 2) + (ef * delta_ef))
          Unit("#{delta_ex} #{self.property_definition.unit(system_of_units)}")
        else
          result.inverse
        end
      else
       result
      end
    end
  end

  def value system_of_units = UnitSystem::DEFAULT
    with_units? && value_object(system_of_units).scalar || attributes['value']
  end

  def value_decorated_for user
    result = self.value(unit_system(user))
    result.round(2).to_f if with_units?
  end

  def units_for user
    system_of_units = unit_system(user)
    unit_type_def = Settings.unit_kinds[self.property_definition.unit_type]

    I18n.t unit_type_def['name'] || unit_type_def[system_of_units]['name'], scope: 'units_new.unit_symbols'
  end

  def value_with_unit_decorated_for user
    "#{value_decorated_for user} #{units_for user}"
  end

  def value_added_and_decorated_for property, user
    system_of_units = unit_system(user)
    result = self.value_object(system_of_units).try(:scalar)
    return if result.blank?
    result += property.value_object().scalar if property.try(:value_object).present?
    return if result.blank?
    result.round(2).to_f
  end

  def name
    @name ||= self.property_definition.name
  end

  def name= name
    if self.property_definition = PropertyDefinition.find_by_name(name)
      @name = name
    end
  end

  def actor= user
    @actor = user
    write_attribute :value, (have_to_normalize? ? normalize(value) : value)
  end

  private

  def unit_system(user = nil)
    user.presence.try(:system_of_units_code) || UnitSystem::DEFAULT
  end

  def have_to_normalize?
    self.actor and self.property_definition.unit and self.actor.system_of_units_code != UnitSystem::DEFAULT
  end

  def normalize value
    system_of_units = self.actor.system_of_units_code || UnitSystem::DEFAULT

    #FIXME: in fact, it supports only 'fuel_consumption' unit_type in the '(property_definition.inverse? and differential?)' branch
    if self.property_definition.inverse?(system_of_units)
      if differential?
        k = normalization_coeff system_of_units
        ef = normalization_base
        delta_ex = value
        (-((ef ** 2) * delta_ex) / (k + (ef * delta_ex))).to_unit(self.property_definition.unit)
      else
        Unit("#{value} 1/#{self.property_definition.unit(system_of_units)}").inverse
      end
    else
      Unit("#{value} #{self.property_definition.unit(system_of_units)}")
    end.to(self.property_definition.unit).scalar.to_f
  end

  def normalization_coeff system_of_units
    Unit(self.property_definition.unit(system_of_units)).to(self.property_definition.unit).scalar
  end

  #FIXME: 1) quick hack, works with ModificationProperty only; 2) stubs missing version property values and may produce nonsense
  def normalization_base
    (property = self.modification.vehicle.version.properties.find_by_name(self.name)) && property.value || 9.41 # 25 MPG (US) / 30 MPG (UK) / 9.41 L/100 km
  end
end
