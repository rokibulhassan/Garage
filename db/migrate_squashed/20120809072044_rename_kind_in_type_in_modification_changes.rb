class RenameKindInTypeInModificationChanges < ActiveRecord::Migration
  def up
    rename_column :modification_changes, :kind, :type
  end

  def down
    rename_column :modification_changes, :type, :kind
  end
end
