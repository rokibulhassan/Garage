class AddHeightToVehicleFigure < ActiveRecord::Migration
  def change
    add_column :vehicle_figures, :height, :integer
  end
end
