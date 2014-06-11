class AddLeastIsBestFlagToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :least_is_best, :boolean, null: false, default: false
  end
end
