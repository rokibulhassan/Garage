class VersionAttributesCollector

  def initialize version
    @version = version
    @relation = Version.joins(:model).where({model_id: @version.model_id}, models: {brand_id: @version.model.brand_id})
    @first_version = @relation.where('versions.id != :id', :id => @version.id).none?
  end

  def bodies
    values_of @relation, "body"
  end

  def names
    relation = @relation.where body: @version.body

    values_of relation, "name"
  end
  
  def second_names
    relation = @relation.where body: @version.body

    values_of relation, "second_name"
  end

  def doors
    values_of @relation, "doors"
  end

  def transmission_details
    values_of @relation, "transmission_details"
  end

  def energies
    values_of @relation, "energy"
  end

  def market_version_names
    Country.all.map &:second
  end

  def production_years
    relation = @relation.where(body: @version.body).order :production_year

    values_of relation, "production_year"
  end

  def production_codes
    relation = @relation.where body: @version.body, production_year: @version.production_year

    values_of relation, "production_code"
  end

  def transmission_numbers
    relation = @relation.where body: @version.body, production_year: @version.production_year

    values_of relation, "transmission_numbers"
  end

  def transmission_types
    relation = @relation.where body: @version.body, production_year: @version.production_year, transmission_numbers: @version.transmission_numbers

    values_of relation, "transmission_type"
  end

  def model_select_options
    ModelSelectOption.options_for_version(@version)
  end

  def attributes attrs = []
    attrs ||= %w(
      body name second_name market_version_name production_year production_code
      transmission_numbers transmission_type doors energy transmission_details
    )

    attr_hash = { first_version: @first_version }
    global_select_options_en = @version.global_select_options(attrs, 'en')
    attr_hash[:global_select_options] = global_select_options_en

    if I18n.locale.to_s != 'en'
      global_select_options_locale = @version.global_select_options(attrs, I18n.locale)
      attr_hash[:global_select_options_translations] = @version.global_select_options_translations(
        'en' => global_select_options_en,
        I18n.locale.to_s => global_select_options_locale
      )
    end

    attr_hash[:model_select_options] = model_select_options
    attr_hash[:model_id] = @version.model_id
    attrs.each do |attr|
      attr_hash[attr] = send(attr.pluralize)
    end
    attr_hash
  end

  private

  def values_of relation, attribute
    relation.uniq.map{|version| VersionDecorator.new(version).send(attribute)}.uniq
  end

end
