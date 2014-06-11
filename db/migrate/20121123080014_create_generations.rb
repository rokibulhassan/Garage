class CreateGenerations < ActiveRecord::Migration
  def up
    create_table :generations do |t|
      t.string :generation
      t.integer :started_at
      t.integer :finished_at
      t.integer :version_id

      t.timestamps
    end

    remove_column :versions, :generation
    remove_column :versions, :generation_started_at
    remove_column :versions, :generation_finished_at
  end

  def down
    drop_table :generations

    add_column :versions, :generation, :string
    add_column :versions, :generation_started_at, :integer
    add_column :versions, :generation_finished_at, :integer
  end

end
