class AddImageBlurAreasToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :image_blur_areas, :text
  end
end
