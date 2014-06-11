class ChangeForeignKeyInModificationChanges < ActiveRecord::Migration
  def up
    remove_column :modification_changes, :property_name
    add_column :modification_changes, :property_instance_id, :integer
    add_index :modification_changes, :property_instance_id
  end

  def down
    add_column :modification_changes, :property_name, :string
    remove_column :modification_changes, :property_instance_id
  end
end
