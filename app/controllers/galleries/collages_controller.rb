class Galleries::CollagesController < ::CollagesController
  load_and_authorize_resource :gallery
  load_and_authorize_resource :through => :gallery, :exclude => [ :index ]

  def index
    @collages = @gallery.collages.includes(:cutouts)
  end
end
