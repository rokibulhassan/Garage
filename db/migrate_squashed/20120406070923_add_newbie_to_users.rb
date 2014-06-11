class AddNewbieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newbie, :boolean, null: false, default: true
  end
end
