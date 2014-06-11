class AddVotableAttributesToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :pending, :boolean, null: false, default: true
    add_column :versions, :rejected, :boolean, null: false, default: false
    add_column :versions, :upvotes_count, :integer, null: false, default: 0
    add_column :versions, :downvotes_count, :integer, null: false, default: 0
  end
end
