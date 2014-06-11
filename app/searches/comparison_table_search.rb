class ComparisonTableSearch
  PER_PAGE_LIMIT = 20

  def initialize(user = nil, options = {})
    @user = user
    @page = (options[:page] || 1).to_i
    @recent = options[:recent]
    @brand_id = options[:brand_id]
    @query = options[:query]
    @limit = options[:limit] || PER_PAGE_LIMIT
    @includes = [:likes, :vehicles => [:side_view]]
    unless @recent || @user
      raise ArgumentError, "user or options[:recent] must be given"
    end
  end

  def results
    scope.limit(@limit).offset((@page - 1) * @limit)
  end

  protected

  def scope
    base_scope.includes(*@includes).order(order)
  end

  def base_scope
    scope = if @recent
      ComparisonTable.scoped
    elsif @user
      @user.comparison_tables
    end

    if @brand_id || @query
      vehicle_ids = VehicleSearch.new(nil, :brand_id => @brand_id, :query => @query).results.map(&:id)
      scope.joins(:vehicles).where(:comparison_table_vehicles => {:vehicle_id => vehicle_ids})
    else
      scope
    end
  end

  def order
    if @recent
      'comparison_tables.id DESC'
    elsif @user
      'comparison_tables.updated_at DESC'
    end
  end

end
