class AddImageRevisionToCutout < ActiveRecord::Migration
  def change
    add_column :cutouts, :image_revision, :integer, :default => 1
  end
end
