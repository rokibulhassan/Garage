class ModificationsController < ApplicationController
  load_resource :vehicle
  load_resource :modification, through: :vehicle, except: :index

  def index
    @modifications = @vehicle.modifications.includes {[part_purchases.part, services.vendor]}
  end

  def create
    if @modification.save
      render :show
    else
      render json: true, status: 403
    end
  end

  def destroy
    if @modification.destroy
      render json: true
    else
      render json: true, status: 403
    end
  end

end
