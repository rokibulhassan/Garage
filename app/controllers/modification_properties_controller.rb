class ModificationPropertiesController < ApplicationController
  load_resource :modification

  def create
    @property = @modification.properties.build(params[:modification_property])
    @property.actor = current_user

    if @property.save
      render json: {id: @property.id}
    else
      render status: 403
    end
  end

  def update
    @property = @modification.properties.find(params[:id])
    @property.attributes = params[:modification_property]
    @property.actor = current_user

    if @property.save
      render json: true
    else
      render status: 403
    end
  end

  def destroy
    if @modification.properties.find(params[:id]).destroy
      render json: true
    else
      render status: 403
    end
  end
end
