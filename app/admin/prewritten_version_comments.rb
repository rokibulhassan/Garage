ActiveAdmin.register PrewrittenVersionComment do

  filter :body_en
  filter :body_fr
  menu priority: 10
  menu :label => "Prewritten Comments"
  actions :all

  config.filters = false
  sidebar :locales do
    render partial: 'admin/prewritten_version_comments/prewritten_comments'
  end

  controller do
    def create
      attrs = params[:prewritten_version_comment]
      if id = params[:id]
        @comment = PrewrittenVersionComment.find(id)
      else
        @comment = PrewrittenVersionComment.new
      end
      if @comment.update_attributes(attrs)
        redirect_to admin_prewritten_version_comment_url(@comment)
      else
        redirect_to admin_prewritten_version_comments_url, :alert => "Error: couldn't create comment."
      end
    end

    def get_prewritten_comments
      @prewritten_comments = PrewrittenVersionComment.order('created_at DESC').all
      respond_to do |format|
        format.js   # renders show.js.erb
      end
    end
    
    def update_prewritten_comments
      loc = params[:locale]
      @pwc = PrewrittenVersionComment.find(params[:update_value])
      @pwc["body_#{loc}"] = params[:value]
      @pwc.save
      redirect_to root_path
    end

    alias update create
  end

  form do |f|
    f.inputs do
      f.input :body_en, as: :text
      f.input :body_fr, as: :text
      f.input :vehicle_type, as: :select, :collection => { Vehicle::AUTOMOBILE => Vehicle::AUTOMOBILE, Vehicle::MOTORCYCLE => Vehicle::MOTORCYCLE }
    end

    f.buttons
  end

  index do
    column :body_en
    column :body_fr
    column :vehicle_type

    default_actions
  end

  scope :all, default: true

  scope :automobiles do
    PrewrittenVersionComment.for_cars
  end
  scope :motorcycles do
    PrewrittenVersionComment.for_motorcycles
  end

  controller { with_role :admin_user }
end
