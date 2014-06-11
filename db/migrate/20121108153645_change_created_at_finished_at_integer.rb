class ChangeCreatedAtFinishedAtInteger < ActiveRecord::Migration
  def up
    remove_column :versions, :generation_started_at
    add_column :versions, :generation_started_at, :integer
    remove_column :versions, :generation_finished_at
    add_column :versions, :generation_finished_at, :integer
  end

  def down
    remove_column :versions, :generation_started_at
    add_column :versions, :generation_started_at, :string
    remove_column :versions, :generation_finished_at
    add_column :versions, :generation_finished_at, :string
  end
end
