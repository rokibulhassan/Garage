class CollagesController < ApplicationController
  def create
    if @collage.save
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def update
    if @collage.update_attributes(params[:collage])
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def destroy
    if @collage.destroy
      render json: true
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end
end
