class BrandsController < ApplicationController
  load_resource only: :create

  def index
    @brands = Brand.not_rejected.order("name DESC")
    @brands = @brands.where(pending: false) if params[:include_pending] == "false"
    @brands = @brands.by_type_in(params[:types]) if params[:types]

    @brands = BrandDecorator.decorate @brands
  end


  def create
    @brand.pending = true
    if @brand.save
      @brand = BrandDecorator.new @brand
      render :show
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end
end
