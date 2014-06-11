class AddVehicleToModifications < ActiveRecord::Migration
  def change
    add_column :modifications, :vehicle_id, :integer
    add_index :modifications, :vehicle_id
  end
end
