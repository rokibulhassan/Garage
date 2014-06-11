class DropMosaicStyleDoorsCountBodyFuelTypeGearBoxFromVehicles < ActiveRecord::Migration
  def up
    remove_column :vehicles, :mosaic_style
    remove_column :vehicles, :doors_count
    remove_column :vehicles, :body
    remove_column :vehicles, :fuel_type
    remove_column :vehicles, :gear_box
  end

  def down
    add_column :vehicles, :mosaic_style, :string, :limit => 50
    add_column :vehicles, :doors_count, :integer
    add_column :vehicles, :body, :string
    add_column :vehicles, :fuel_type, :string
    add_column :vehicles, :gear_box, :string
  end
end
