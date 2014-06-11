class RenameApprovedInPendingInFixable < ActiveRecord::Migration
  def up
    rename_column :brands, :approved, :pending
  end

  def down
    rename_column :brands, :pending, :approved
  end
end
