class RenameUriIntoUrlInVehicleFigures < ActiveRecord::Migration
  def up
    rename_column :vehicle_figures, :uri, :url
  end

  def down
    rename_column :vehicle_figures, :url, :uri
  end
end
