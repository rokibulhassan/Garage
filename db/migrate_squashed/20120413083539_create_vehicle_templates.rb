class CreateVehicleTemplates < ActiveRecord::Migration
  def change
    create_table :vehicle_templates do |t|
      t.string :name

      t.timestamps
    end
  end
end
