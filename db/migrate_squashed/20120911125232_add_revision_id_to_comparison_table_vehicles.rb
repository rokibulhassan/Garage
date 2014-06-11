class AddRevisionIdToComparisonTableVehicles < ActiveRecord::Migration
  def change
    add_column :comparison_table_vehicles, :revision_id, :integer
    add_index :comparison_table_vehicles, :revision_id
  end
end
