class AddVehicleIdToPictures < ActiveRecord::Migration
  def up
    add_column :pictures, :vehicle_id, :integer
  end

  def down
    remove_column :pictures, :vehicle_id
  end
end
