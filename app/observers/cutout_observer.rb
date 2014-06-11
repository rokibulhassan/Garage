class CutoutObserver < ActiveRecord::Observer
  def before_update cutout
    if cutout.picture
      cutout.image_revision += 1
      cutout.image = cutout.picture.image.big
    end
  end
end
