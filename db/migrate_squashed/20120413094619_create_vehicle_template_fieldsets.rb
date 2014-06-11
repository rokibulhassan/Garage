class CreateVehicleTemplateFieldsets < ActiveRecord::Migration
  def change
    create_table :vehicle_template_fieldsets do |t|
      t.string :name
      t.references :vehicle_template

      t.timestamps
    end
  end
end
