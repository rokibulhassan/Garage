class AddCityPublicFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city_public, :boolean, null: false, default: false
  end
end
