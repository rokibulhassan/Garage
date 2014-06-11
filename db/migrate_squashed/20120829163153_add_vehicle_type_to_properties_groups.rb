class AddVehicleTypeToPropertiesGroups < ActiveRecord::Migration
  def change
    add_column :properties_groups, :vehicle_type, :string
  end
end
