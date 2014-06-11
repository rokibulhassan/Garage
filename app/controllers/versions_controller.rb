class VersionsController < ApplicationController
  load_resource only: [:create, :update, :show]

  def index
    @brand = Brand.find(params[:brand_id])
    @model = @brand.models.find(params[:model_id])

    @versions = @model.versions.map {|version| VersionDecorator.new version}
  end


  def create
    if @version.save
      @version = VersionDecorator.new @version
      render :show
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  def show
    @version = VersionDecorator.new @version
  end

  def update
    if @version.update_attributes params[:version]
      @version = VersionDecorator.new @version
      render :show
    else
      render :json => [{:error => "custom_failure"}], :status => 403
    end
  end

  # GET /versions/prewritten_comments
  def get_prewritten_comments
    comments = PrewrittenVersionComment.all
    render :json => comments
  end

  # POST /versions/prewritten_comments
  def post_prewritten_comments
    version_id, prewritten_comment_id = params[:version_id], params[:prewritten_comment_id]
    if prewritten_comment_id.zero?
      PrewrittenCommentsVersionUser.where(:version_id => version_id, :user_id => (params[:user_id] || current_user.id)).first.destroy
    else
      comment = PrewrittenVersionComment.find(prewritten_comment_id)
      comment.associate_with_user_and_version!(current_user, Version.find(version_id))
    end
    render :json => {}
  rescue ActiveRecord::RecordNotFound
    render :json => {}, :status => 500
  end

  # GET /versions/:id/comments
  def comments
    @version = Version.find(params[:id])
    @comments = @version.comments_as_json
    render 'version_comments/index'
  end

end
