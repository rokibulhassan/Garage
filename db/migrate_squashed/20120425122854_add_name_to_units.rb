class AddNameToUnits < ActiveRecord::Migration
  def change
    add_column :units, :name, :string
  end
end
