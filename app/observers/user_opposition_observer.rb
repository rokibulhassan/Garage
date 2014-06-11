class UserOppositionObserver < ActiveRecord::Observer
  def after_create(user_opposition)
    user_opposition.opposer.comments
      .joins { [ picture.gallery.vehicle ] }
      .where { picture.gallery.vehicle.user_id.eq my{user_opposition.user.id} }
      .map &:destroy
  end
end
