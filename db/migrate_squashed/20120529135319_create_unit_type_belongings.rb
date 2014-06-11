class CreateUnitTypeBelongings < ActiveRecord::Migration
  def change
    create_table :unit_type_belongings do |t|
      t.references :unit_system
      t.references :unit_type
      t.references :unit

      t.timestamps
    end
    add_index :unit_type_belongings, :unit_system_id
    add_index :unit_type_belongings, :unit_type_id
    add_index :unit_type_belongings, :unit_id
  end
end
