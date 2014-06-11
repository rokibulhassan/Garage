class SideViewsController < ApplicationController
  load_resource :version, only: :index
  load_resource

  def show
  end

  def index
    @side_views = SideView.same_to @version
  end

end
