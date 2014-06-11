class AddBrandAndModelToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :brand_id, :integer
    add_index :vehicles, :brand_id
    add_column :vehicles, :model_id, :integer
    add_index :vehicles, :model_id
  end
end
