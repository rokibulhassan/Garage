class AddGalleryIdToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :gallery_id, :integer
    add_index :pictures, :gallery_id
  end
end
