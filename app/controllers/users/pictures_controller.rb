class Users::PicturesController < ApplicationController
  load_resource :user

  def index
    @pictures = @user.gallery_pictures

    render 'pictures/index'
  end
end
