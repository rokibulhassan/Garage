class RepairComparisonTableVehicles < ActiveRecord::Migration
  def up
    remove_column :comparison_table_vehicles, :properties
  end

  def down
    add_column :comparison_table_vehicles, :properties, :text
  end
end
