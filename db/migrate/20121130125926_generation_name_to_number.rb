class GenerationNameToNumber < ActiveRecord::Migration
  def up
    add_column :generations, :number, :integer
    remove_column :generations, :name
  end

  def down
    add_column :generations, :name, :string
    remove_column :generations, :number
  end
end
