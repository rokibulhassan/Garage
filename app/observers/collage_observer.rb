class CollageObserver < ActiveRecord::Observer
  def before_update collage
    if collage.move
      direction = collage.move
      collage.move = nil
      direction == 'higher' ? collage.move_higher : collage.move_lower
    end
  end
end
