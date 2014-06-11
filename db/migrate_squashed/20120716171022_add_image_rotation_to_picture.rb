class AddImageRotationToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :image_rotation, :integer, :default => 0
  end
end
