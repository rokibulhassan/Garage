class ChangeSystemOfUnitsFromStringToIndex < ActiveRecord::Migration
  def up
    change_column :users, :system_of_units, :integer
    rename_column :users, :system_of_units, :system_of_units_id
  end

  def down
    change_column :users, :system_of_units, :string
    rename_column :users, :system_of_units_id, :system_of_units
  end
end
