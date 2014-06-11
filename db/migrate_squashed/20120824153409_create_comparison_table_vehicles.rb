class CreateComparisonTableVehicles < ActiveRecord::Migration
  def change
    create_table :comparison_table_vehicles do |t|
      t.references :comparison_table
      t.references :vehicle
      t.text :properties

      t.timestamps
    end
    add_index :comparison_table_vehicles, :comparison_table_id
    add_index :comparison_table_vehicles, :vehicle_id
  end
end
