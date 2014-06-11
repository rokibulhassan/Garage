class CreateModificationChanges < ActiveRecord::Migration
  def change
    create_table :modification_changes do |t|
      t.references :modification
      t.string :property_name

      t.timestamps
    end
    add_index :modification_changes, :modification_id
  end
end
