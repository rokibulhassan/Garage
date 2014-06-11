class CreateVersionVehicleFigures < ActiveRecord::Migration
  def change
    create_table :version_vehicle_figures do |t|
      t.references :version
      t.references :vehicle_figure
      t.boolean :default, null: false, default: false

      t.timestamps
    end
    add_index :version_vehicle_figures, :version_id
    add_index :version_vehicle_figures, :vehicle_figure_id
  end
end
