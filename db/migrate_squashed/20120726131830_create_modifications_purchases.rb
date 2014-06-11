class CreateModificationsPurchases < ActiveRecord::Migration
  def change
    create_table :modification_parts do |t|
      t.references :part
      t.references :modification
      t.integer :quantity

      t.timestamps
    end
    add_index :modification_parts, :part_id
    add_index :modification_parts, :modification_id
  end
end
