class AddSecondNameToVersions < ActiveRecord::Migration
  def up
    add_column :versions, :second_name, :string
  end
  
  def down
    remove_column :versions, :second_name
  end
end
