class AddFieldsToVehicleTemplateFieldDefinitions < ActiveRecord::Migration
  def change
    add_column :vehicle_template_field_definitions, :unit_id, :integer
    add_index :vehicle_template_field_definitions, :unit_id
    add_column :vehicle_template_field_definitions, :values, :text
    add_column :vehicle_template_field_definitions, :values_type, :string
    add_column :vehicle_template_field_definitions, :scoped_by, :string
  end
end
