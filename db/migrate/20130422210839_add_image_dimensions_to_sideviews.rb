class AddImageDimensionsToSideviews < ActiveRecord::Migration
  def up
    add_column :side_views, :image_dimensions, :text
  end

  def down
    remove_column :side_views, :image_dimensions
  end
end
