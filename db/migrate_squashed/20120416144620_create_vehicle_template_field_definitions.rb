class CreateVehicleTemplateFieldDefinitions < ActiveRecord::Migration
  def change
    create_table :vehicle_template_field_definitions do |t|
      t.string :name
      t.string :label_fr
      t.string :label_en
      t.string :type
      t.string :type
      t.references :fieldset

      t.timestamps
    end
    add_index :vehicle_template_field_definitions, :fieldset_id
  end
end
