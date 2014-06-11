class VehiclesController < ApplicationController
  load_and_authorize_resource only: [:update], class: VehicleDecorator
  load_and_authorize_resource only: :create

  def create
    if @vehicle.save
      @vehicle = VehicleDecorator.new @vehicle
      render :show
    else
      render json: true, status: 403
    end
  end

  def show
    @vehicle = Vehicle.approved.find_by_id(params[:id]) || current_user.vehicles.find(params[:id])
    @vehicle = VehicleDecorator.new @vehicle
  end

  def update
    if @vehicle.update_attributes params[:vehicle]
      render :show
    else
      render json: true, status: 403
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    if current_user.id == @vehicle.user.id && @vehicle.destroy
      render json: true
    else
      render json: true, status: 403
    end
  end

  def update_avatar
    @vehicle = current_user.vehicles.find(params[:id])
    @vehicle.avatar = params[:avatar]
    @vehicle.save!

    @vehicle = VehicleDecorator.new @vehicle
  end

  def index
    @user     = User.find(params[:user_id])
    @vehicles = @user.vehicles
    unless current_user.try(:id) == @user.id
      @vehicles = @vehicles.approved
    end
    @vehicles = @vehicles.where(vehicle_type: params[:type]) if params[:type].in?(Vehicle::TYPES)
    @vehicles = VehicleDecorator.decorate @vehicles

    render :index
  end

  def search
    @vehicles = VehicleSearch.new(current_user, params).vehicles
    @vehicles = VehicleDecorator.decorate @vehicles

    respond_to do |format|
      format.json { render :index }
    end
  end
end
