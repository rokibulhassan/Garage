class CommentsController < ApplicationController
  load_resource :picture
  load_and_authorize_resource :comment, :through => :picture

  def index
    @comments = @picture.comments_visible_by(current_user) if current_user
    @comments = @comments.includes(:user)
  end

  def create
    @comment.user = current_user
    if @comment.save
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def update
    if @comment.update_attributes(params[:comment])
      render 'show'
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def destroy
    @comment.destroy

    render json: true
  end
end
