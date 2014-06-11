class VehicleBookmarksController < ApplicationController
  load_resource :vehicle

  def create
    if current_user.bookmarked_vehicles << @vehicle
      @vehicle = VehicleDecorator.new @vehicle
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def destroy
    if current_user.bookmarked_vehicles.delete @vehicle
      render json: true
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end
end
