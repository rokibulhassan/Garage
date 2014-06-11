class AddPictureToCutouts < ActiveRecord::Migration
  def change
    add_column :cutouts, :picture_id, :integer
  end
end
