class ModelsController < ApplicationController
  load_resource :brand, only: :create
  load_resource only: :create, through: :brand

  def index
    @models = Model.not_rejected.order('name DESC')
    @models = @models.where(vehicle_type: params[:type]) if params[:type]
    return @models unless params[:brand_id]
    @models = @models.joins(:brand).
      where(brand_id: params[:brand_id]).
      where(:brands => { :rejected => false })
  end

  def create
    @model.pending = true
    if @model.save
      render :show
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def update_model_select_options
    @model = Model.find(params[:id])
    options = @model.model_select_options.find_or_initialize_by_name(params[:name])
    if options && options.update_attributes(params.slice(:options))
      render :json => options
    else
      render :json => {}, :status => 403
    end
  end
end
