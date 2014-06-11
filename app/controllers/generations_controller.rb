class GenerationsController < ApplicationController
  load_resource :version
  load_resource through: :version, singleton: true

  def index
    @generations = Collectors::Generations.new(@version).generations
  end

  def update
    if @generation.update_attributes params[:generation]
      render :show
    else
      render :json => true, :status => 403
    end
  end

end
