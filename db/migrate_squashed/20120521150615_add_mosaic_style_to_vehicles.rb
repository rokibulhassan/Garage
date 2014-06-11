class AddMosaicStyleToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :mosaic_style, :string, limit: 50
  end
end
