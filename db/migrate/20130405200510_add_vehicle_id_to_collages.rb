class AddVehicleIdToCollages < ActiveRecord::Migration
  def up
    add_column :collages, :vehicle_id, :integer
  end

  def down
    remove_column :collages, :vehicle_id
  end
end
