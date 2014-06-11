class AddWidthToVehicleFigures < ActiveRecord::Migration
  def change
    add_column :vehicle_figures, :width, :integer
  end
end
