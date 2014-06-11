class AddImageRevisionToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :image_revision, :integer, :default => 1
  end
end
