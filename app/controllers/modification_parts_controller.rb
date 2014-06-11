class ModificationPartsController < ApplicationController
  load_resource :vehicle
  load_resource :modification, trough: :vehicle

  def create
    @modification_part = @modification.modification_parts.create! params[:modification_part]
    render :show
  end


  def update
    @modification_part = @modification.modification_parts.find params[:id]
    @modification_part.update_attributes params[:modification_part]
    render :show
  end


  def destroy
    modification_part = @modification.modification_parts.find params[:id]
    modification_part.destroy
    render json: true
  end
end
