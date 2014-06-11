class FollowersController < ApplicationController

  def index
    @followers = User.includes(:followings).uniq.where(followings: {thing_id: current_user.id, thing_type: current_user.class.to_s} )
  end

end