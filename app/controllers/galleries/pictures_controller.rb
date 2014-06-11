class Galleries::PicturesController < ::PicturesController
  load_and_authorize_resource :gallery, :except => [:index]
  load_and_authorize_resource :picture, :through => :gallery, :except => [:index]

  def index
    @gallery = Gallery.find(params[:gallery_id])
    @pictures = @gallery.pictures
  end

  def create
    if @picture.save
      @gallery.update_attributes(:cover_picture_id => @picture.id, :finished => true) unless @gallery.finished?
      respond_to do |format|
        format.html { render :show, formats: [:json] }
        format.json { render :show }
      end
    else
      render json: [{error: "custom_failure"}], status: 304
    end
  end
end
