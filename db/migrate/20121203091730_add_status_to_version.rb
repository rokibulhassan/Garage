class AddStatusToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :status, :string
  end
end
