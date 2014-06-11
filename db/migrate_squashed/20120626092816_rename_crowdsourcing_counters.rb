class RenameCrowdsourcingCounters < ActiveRecord::Migration
  def up
    rename_column :brands, :approvals_count, :upvotes_count
    rename_column :brands, :disapprovals_count, :downvotes_count

    rename_column :fixes, :approvals_count, :upvotes_count
    rename_column :fixes, :disapprovals_count, :downvotes_count
  end

  def down
    rename_column :brands, :upvotes_count, :approvals_count
    rename_column :brands, :downvotes_count, :disapprovals_count

    rename_column :fixes, :upvotes_count, :approvals_count
    rename_column :fixes, :downvotes_count, :disapprovals_count
  end
end
