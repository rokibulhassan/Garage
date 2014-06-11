class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.references :vehicle
      t.references :field_definition
      t.integer :static_value_id
      t.string :value
      t.integer :dynamic_value_id
      t.integer :unit_id

      t.timestamps
    end
    add_index :attributes, :vehicle_id
    add_index :attributes, :field_definition_id
  end
end
