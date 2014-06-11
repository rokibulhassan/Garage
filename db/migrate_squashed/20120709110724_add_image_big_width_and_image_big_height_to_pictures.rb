class AddImageBigWidthAndImageBigHeightToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :image_big_width, :integer
    add_column :pictures, :image_big_height, :integer
  end
end
