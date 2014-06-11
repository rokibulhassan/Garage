class ComparisonTablesController < ApplicationController
  load_resource :through => :current_user, except: [:index, :show, :save, :like]

  def index
    @user = User.find_by_id(params[:user_id]) || current_user
    search = ComparisonTableSearch.new(@user,
      :recent => params[:recent],
      :brand_id => params[:brand_id],
      :query => params[:query],
      :page => params[:page]
    )
    @comparison_tables = search.results
  end

  def create
    if @comparison_table.save
      render :show
    else
      render json: true, status: 403
    end
  end

  def show
    @user = current_user
    @comparison_table = ComparisonTable.find(params[:id])
  end

  def update
    @user = current_user
    if @comparison_table.update_attributes params[:comparison_table]
      render :show
    else
      render json: true, status: 403
    end
  end

  def save
    @user = current_user
    @comparison_table = ComparisonTable.find(params[:id])
    if @user.save_comparison_table(@comparison_table)
      render json: true, status: 201
    else
      render json: true, status: 500
    end
  end

  def like
    @user = current_user
    @comparison_table = ComparisonTable.find(params[:id])
    if @user.like_comparison_table(@comparison_table)
      render json: true, status: 201
    else
      render json: true, status: 500
    end
  end

  # PUT /comparison_tables/1/import
  # Params: comparison_table_vehicles: [ { vehicle_id: 1, revision_id: null }, { vehicle_id: 2, revision_id: 8 } ]
  def import
    comparison_table = current_user.comparison_tables.find(params[:id])

    Vehicle.transaction do
      params[:vehicles_with_revision].each do |index, vehicle_with_revision|
        comparison_table.comparison_table_vehicles.create! do |ctv|
          ctv.vehicle  = Vehicle.find(vehicle_with_revision[:vehicle_id])
          ctv.revision = ctv.vehicle.revisions.find(vehicle_with_revision[:revision_id]) if vehicle_with_revision[:revision_id]
        end
      end
    end

    render json: true
  end
end
