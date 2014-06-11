class VersionPropertiesController < ApplicationController
  load_resource :version

  def create
    @property = @version.properties.build(params[:version_property])
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    @property.accepted = true if @vehicle.presence.try(:user) == current_user
    @property.actor = current_user
    @property.user_id = current_user.id

    if @property.save
      render :show
    else
      render json: true, status: 403
    end
  end

  def update
    @property = @version.properties.find(params[:id])
    @property.attributes = params[:version_property]
    @property.actor = current_user

    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    own_data = @vehicle.user == current_user
    validating = own_data && params[:validating]

    if validating
      accepted = params[:accepted]
      @property.accepted = accepted
      @property.is_rejected = true if accepted == false
    elsif own_data
      @property.accepted = true
      @property.user_id = current_user.id
    else
      @property.accepted = nil
      @property.user_id = current_user.id
    end

    if @property.save
      render :show
    else
      render json: true, status: 403
    end
  end
end
