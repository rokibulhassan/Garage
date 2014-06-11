class Profiles::PicturesController < ::PicturesController
  load_resource :profile, class: User
  load_resource :album
  load_and_authorize_resource :picture, through: :profile, except: [:index, :create]
  load_resource :picture, through:  :album, only: :create

  def index
    @pictures = ProfilePictureSearch.new(@profile, album: @album, page: params[:page]).profile_pictures
  end

  def new
  end

  def create
    if @picture.save
      render :show
    else
      render json: [{error: "custom_failure"}], status: 304
    end
  end
end
