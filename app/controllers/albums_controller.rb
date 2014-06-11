class AlbumsController < ApplicationController
  load_resource :album, through: :current_user, only: [:show, :update]
  load_resource :user, only: :index

  def show
  end

  def create
    pictures = current_user.pictures.where(id: params[:picture_ids])

    @gallery = Album.new params[:album]
    @gallery.user = current_user
    @gallery.cover_picture = pictures.first if pictures.any?

    if @gallery.save
      @gallery.pictures << pictures
      render json: {id: @gallery.id}
    else
      render json: true, status: 403
    end
  end

  def update
    if @album.update_attributes(params[:album])
      render :show
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def index
    @albums = AlbumSearch.new(params[:public], params[:public] ? @user : current_user).albums
  end
end