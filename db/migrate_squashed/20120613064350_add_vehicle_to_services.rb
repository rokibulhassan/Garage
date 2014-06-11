class AddVehicleToServices < ActiveRecord::Migration
  def change
    add_column :services, :vehicle_id, :integer
    add_index :services, :vehicle_id
  end
end
