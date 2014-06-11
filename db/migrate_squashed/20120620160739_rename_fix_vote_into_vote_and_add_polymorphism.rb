class RenameFixVoteIntoVoteAndAddPolymorphism < ActiveRecord::Migration
  def up
    rename_table :fix_votes, :votes
    rename_column :votes, :fix_id, :fixable_id
    add_column :votes, :fixable_type, :string
  end

  def down
    remove_column :votes, :fixable_type
    rename_column :votes, :fixable_id, :fix_id
    rename_table :votes, :fix_votes
  end
end
