class RenameFieldInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :confirmed_ad, :confirmed_at
  end

  def down
    rename_column :users, :confirmed_at, :confirmed_ad
  end
end
