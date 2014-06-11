class AddDoorsCountToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :door_count, :integer
  end
end
