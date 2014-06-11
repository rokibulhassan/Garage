class PartPurchasesController < ApplicationController
  load_resource

  def create
    if @part_purchase.save
      render :show
    else
      render json: true, status: 403
    end
  end

  def update
    if @part_purchase.update_attributes params[:part_purchase]
      render :show
    else
      render json: true, status: 403
    end
  end

  def destroy
    @part_purchase.destroy
    render json: true
  end
end
