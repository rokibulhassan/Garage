class AddProfileIdToCollages < ActiveRecord::Migration
  def change
    add_column :collages, :profile_id, :integer
  end
end
