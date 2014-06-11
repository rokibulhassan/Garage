class AddFieldToFieldDefinitions < ActiveRecord::Migration
  def change
    add_column :field_definitions, :unit_type_id, :integer
    add_index :field_definitions, :unit_type_id
  end
end
