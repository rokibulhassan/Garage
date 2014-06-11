class PicturesController < ApplicationController
  def show
  end

  def update
    if @picture.update_attributes(params[:picture])
      render :show
    else
      render json: [{error: "custom_failure"}], status: 403
    end
  end

  def destroy
    @picture.destroy

    render json: true
  end
end
