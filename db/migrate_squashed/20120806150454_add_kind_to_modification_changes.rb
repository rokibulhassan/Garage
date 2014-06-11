class AddKindToModificationChanges < ActiveRecord::Migration
  def change
    add_column :modification_changes, :kind, :string
  end
end
