require 'open-uri'

class Bookmarklet::FavoritesController < ApplicationController
  layout 'bookmarklet'

  def new
    @url      = params[:url]
    @page_url = params[:pageUrl]
  end


  # This action may be called with a unsigned user.
  def create
    sign_user_in(identified_user, given_password)

    if current_user
      image_file = open(params[:favorite][:url])
      attributes = params[:favorite].merge(image: image_file)
      @favorite  = current_user.favorites.build(attributes)
      @favorite.save!
      render inline: '<script>window.close();</script>'
    else
      @url      = params[:favorite][:url]
      @page_url = params[:favorite][:page_url]
      render :new
    end
  end
end
