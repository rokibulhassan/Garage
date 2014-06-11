class RemoveSystemOfUnitsCodeFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :system_of_units_code
  end

  def down
    add_column :users, :system_of_units_code, :string
  end
end
