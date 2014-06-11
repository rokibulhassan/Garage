class AddLayoutToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :layout, :string, :default => 'grid'
  end
end
