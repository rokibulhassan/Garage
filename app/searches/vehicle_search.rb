class VehicleSearch
  # TODO: use pagination or lower this number
  PER_PAGE_LIMIT = 100

  def initialize user, opts = {}
    @user = user
    @bookmarks = opts[:bookmarks]
    @brand_id = opts[:brand_id]
    @excl_brand_ids = opts[:excl_brand_ids]
    @model_id = opts[:model_id]
    @type = opts[:type]
    @country_code = opts[:country_code]
    @excl_country_codes = opts[:excl_country_codes]
    @limit = opts[:limit] || PER_PAGE_LIMIT
    @query = opts[:query]
  end

  def vehicles
    vehicles = base_relation

    vehicles = vehicles.joins { version.model }.where { version.model.brand_id.eq my{@brand_id} } unless @brand_id.blank?
    vehicles = vehicles.joins { version.model }.where { version.model.brand_id.not_in my{@excl_brand_ids} } unless @excl_brand_ids.blank?
    vehicles = vehicles.where { version.model_id.eq my{@model_id} } unless @model_id.blank?
    vehicles = vehicles.where { vehicle_type == my{@type} } unless @type.blank?
    vehicles = vehicles.joins { [ user ] }.where { user.country_code.eq my{@country_code} } unless @country_code.blank?
    vehicles = vehicles.joins { [ user ] }.where { user.country_code.not_in my{@excl_country_codes} } unless @excl_country_codes.blank?

    unless @query.blank?
      vehicles = vehicles.joins { [ version.model ] }.where { (version.model.name.like my{"%#{@query}%"}) |
          (version.label_en.like my{"%#{@query}%"}) |
          (version.label_fr.like my{"%#{@query}%"})
      }
    end

    vehicles
  end
  alias results vehicles

  private

  def base_relation
    vehicles = @bookmarks == 'yes' ? @user.bookmarked_vehicles : Vehicle.approved

    vehicles = vehicles.includes({version: [{model: :brand},:generation]},
                                 {part_purchases: [:part, :vendor]},
                                 :ownership,
                                 :side_view)

    vehicles.order('updated_at desc').limit(@limit)
  end
end
