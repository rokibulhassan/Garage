class CutoutsController < ApplicationController
  load_resource :picture
  load_and_authorize_resource :collage
  load_and_authorize_resource :cutout, :through => :collage, :except => [:index]

  def create
    @cutout.picture = @picture
    if @picture
      @cutout.image = @picture.image.big
    end

    if @cutout.save
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def index
    @cutouts = @collage.cutouts_with_placeholders
  end

  def update
    @cutout.picture = @picture
    if @cutout.update_attributes(params[:cutout])
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end
end
