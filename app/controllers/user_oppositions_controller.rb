class UserOppositionsController < ApplicationController
  load_resource through: :current_user

  def create
    if @user_opposition.save
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end
end
