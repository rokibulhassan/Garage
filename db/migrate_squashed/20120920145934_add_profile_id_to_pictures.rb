class AddProfileIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :profile_id, :integer
  end
end
