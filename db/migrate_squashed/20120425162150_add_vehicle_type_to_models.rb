class AddVehicleTypeToModels < ActiveRecord::Migration
  def change
    add_column :models, :vehicle_type, :string
  end
end
