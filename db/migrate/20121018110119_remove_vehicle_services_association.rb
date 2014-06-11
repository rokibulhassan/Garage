class RemoveVehicleServicesAssociation < ActiveRecord::Migration
  def up
    remove_column :services, :vehicle_id
  end

  def down
    add_column :services, :vehicle_id, :integer
  end
end
