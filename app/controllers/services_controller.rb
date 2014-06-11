class ServicesController < ApplicationController
  load_and_authorize_resource :vehicle
  load_and_authorize_resource :modification, through: :vehicle
  load_and_authorize_resource :service, through: :modification, except: [:index]

  def create
    if @service.save
      render :show
    else
      render json: true, status: 403
    end
  end

  def index
    @services = @modification.services
  end

  def update
    if @service.update_attributes params[:service]
      render :show
    else
      render json: true, status: 403
    end
  end

  def destroy
    @service.destroy
    render json: true
  end
end
