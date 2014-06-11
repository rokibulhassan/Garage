class AddTypeToCollages < ActiveRecord::Migration
  def change
    add_column :collages, :type, :string
    execute 'UPDATE collages SET type = "GalleryCollage" WHERE type IS NULL'
  end
end
