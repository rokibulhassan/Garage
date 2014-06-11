class CreateVehicleFigures < ActiveRecord::Migration
  def change
    create_table :vehicle_figures do |t|
      t.string :label
      t.string :uri
      t.references :model

      t.timestamps
    end
    add_index :vehicle_figures, :model_id
  end
end
