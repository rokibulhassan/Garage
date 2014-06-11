class RenameFieldDefinitionTable < ActiveRecord::Migration
  def up
    rename_table :vehicle_template_field_definitions, :field_definitions
  end

  def down
    rename_table :field_definitions, :vehicle_template_field_definitions
  end
end
