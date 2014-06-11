class AddAttributesToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :generation, :string
    add_column :versions, :generation_started_at, :string
    add_column :versions, :generation_finished_at, :string
    add_column :versions, :production_code, :string
    add_column :versions, :body, :string
    add_column :versions, :transmission, :string
    add_column :versions, :market_version_name, :string
  end
end
