class OwnershipsController < ApplicationController
  load_resource :vehicle
  load_resource :ownership, through: :vehicle, singleton: true

  def show
  end

  def update
    if @ownership.update_attributes params[:ownership]
      render :show
    else
      render json: true, status: 403
    end
  end
end
