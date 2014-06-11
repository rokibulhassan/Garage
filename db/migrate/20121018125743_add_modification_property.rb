class AddModificationProperty < ActiveRecord::Migration
  def up
    create_table :modification_properties do |t|
      t.integer :property_definition_id
      t.integer :modification_id
      t.string :value, null: false
      t.boolean :advantage, default: true, null: false
      t.timestamps
    end

    add_index :modification_properties, [:modification_id, :property_definition_id], name: :by_modification_and_property_definition, unique: true
  end

  def down
    drop_table :modification_properties
  end
end
