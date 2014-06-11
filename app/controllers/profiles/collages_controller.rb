class Profiles::CollagesController < ::CollagesController
  load_resource :profile, :class => User
  load_and_authorize_resource :through => :profile, :exclude => [ :index ]

  def index
    @collages = @profile.collages.includes(:cutouts => { :picture => :gallery })
  end
end
