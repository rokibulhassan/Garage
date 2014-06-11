class ChangeSetsController < ApplicationController
  load_and_authorize_resource :vehicle
  load_and_authorize_resource :change_set, through: :vehicle, except: [:index, :current]

  def create
    if @change_set.save
      render :show
    else
      render json: true, status: 403
    end
  end

  def show
  end

  def update
    if @change_set.update_attributes params[:change_set]
      render :show
    else
      render json: true, status: 403
    end
  end

  def index
    @change_sets = @vehicle.change_sets.without_defaults
  end

  def destroy
    if @change_set.destroy
      render json: true
    else
      render json: true, status: 403
    end
  end

  def current
    if @change_set = @vehicle.current_change_set || @vehicle.build_current_change_set
      render :show
    else
      render json: true, status: 403
    end
  end

end
