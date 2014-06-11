class FavoritesController < ApplicationController
  def index
    @user      = User.find(params[:id])
    @favorites = @user.favorites
  end


  def my_index
    @favorites = current_user.favorites
  end


  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy

    render json: true
  end
end
