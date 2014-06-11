class FollowingsController < ApplicationController
  load_resource :following, only: :destroy

  def create
    @following = current_user.followings.build(params[:following])
    if @following.save
      render :show
    else
      render json: true, status: 403
    end
  end

  def index
    @followings = current_user.followings
  end

  def destroy
    if @following.destroy
      render json: true
    else
      render json: true, status: 403
    end
  end

end