class Galleries::PictureObserver < ActiveRecord::Observer
  def before_update(picture)
    should_recreate_versions =
      picture.rotate ||
      picture.blur ||
      picture.unblur ||
      false

    if picture.rotate
      picture.rotate == 'right' ? picture.image_rotation += 90 : picture.image_rotation -= 90
      picture.image_rotation = 0 if picture.image_rotation.abs == 360

      picture.image_blur_areas.clear
    end

    if picture.blur
      picture.image_blur_areas << picture.blur
    end

    if picture.unblur
      picture.image_blur_areas.clear
    end

    if should_recreate_versions
      picture.image_revision += 1
      picture.image.recreate_versions!
    end
  end
end
