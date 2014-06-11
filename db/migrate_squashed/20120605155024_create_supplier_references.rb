class CreateSupplierReferences < ActiveRecord::Migration
  def change
    create_table :supplier_references do |t|
      t.string :name
      t.string :reference
      t.boolean :obsolete
      t.references :part

      t.timestamps
    end
    add_index :supplier_references, :part_id
  end
end
