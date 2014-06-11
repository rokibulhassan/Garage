class RenameAttributeIntoAttributeNameInFixes < ActiveRecord::Migration
  def up
    rename_column :fixes, :attribute, :attribute_name
  end

  def down
    rename_column :fixes, :attribute_name, :attribute
  end
end
