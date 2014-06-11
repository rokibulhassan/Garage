class AddVehicleTypesToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :vehicle_types, :string
  end
end
