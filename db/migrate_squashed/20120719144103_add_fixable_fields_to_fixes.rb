class AddFixableFieldsToFixes < ActiveRecord::Migration
  def change
    add_column :fixes, :pending, :boolean, null: false, default: true
    add_column :fixes, :rejected, :boolean, null: false, default: false
  end
end
