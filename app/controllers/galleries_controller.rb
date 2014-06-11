class GalleriesController < ApplicationController
  load_and_authorize_resource :vehicle, except: [:index, :gallery_pictures, :show]
  load_and_authorize_resource :gallery, through: :vehicle, except: [:index, :gallery_pictures, :show]


  def tab
    render text: '', layout: true
  end


  def index
    @vehicle = Vehicle.find(params[:vehicle_id])
    @galleries = @vehicle.galleries.includes(:cover_picture)
  end

  def create
    if @gallery.save
      render :show
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def update
    if @gallery.update_attributes(params[:gallery])
      render :show
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def destroy
    @gallery.destroy

    render json: true
  end

  def gallery_pictures
    vehicle_scope = Vehicle.includes(:galleries => [:pictures]).where(:galleries => {:vehicle_id => params[:vehicle_id]})
    @pictures = vehicle_scope.first.galleries.map(&:pictures).flatten rescue []
    render 'pictures/index'
  end
end
