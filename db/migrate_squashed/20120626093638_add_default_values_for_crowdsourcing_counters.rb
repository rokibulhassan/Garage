class AddDefaultValuesForCrowdsourcingCounters < ActiveRecord::Migration
  def up
    change_column :brands, :upvotes_count, :integer, default: 0
    change_column :brands, :downvotes_count, :integer, default: 0

    change_column :fixes, :upvotes_count, :integer, default: 0
    change_column :fixes, :downvotes_count, :integer, default: 0
  end

  def down
    change_column :brands, :upvotes_count, :integer, default: nil
    change_column :brands, :downvotes_count, :integer, default: nil

    change_column :fixes, :upvotes_count, :integer, default: nil
    change_column :fixes, :downvotes_count, :integer, default: nil
  end
end
