class UseStringInsteadOfReferenceForSystemOfUnits < ActiveRecord::Migration
  def up
    add_column :users, :system_of_units_code, :string
    remove_column :users, :system_of_units_id
  end

  def down
    remove_column :users, :system_of_units_code
    add_column :users, :system_of_units_id, :integer
  end
end
