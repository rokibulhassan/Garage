class PartsController < ApplicationController
  def create
    @part = Part.create!(params[:part])
    render json: { id: @part.id }
  end


  def index
    @parts = Part.all
  end
end
