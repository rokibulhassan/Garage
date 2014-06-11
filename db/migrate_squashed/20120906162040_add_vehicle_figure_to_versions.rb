class AddVehicleFigureToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :vehicle_figure_id, :integer
    add_index :versions, :vehicle_figure_id
  end
end
