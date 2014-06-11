class GenerationGenerationToGenerationName < ActiveRecord::Migration
  def up
    remove_column :generations, :generation
    add_column :generations, :name, :string
  end

  def down
    add_column :generations, :generation, :string
    remove_column :generations, :name
  end
end
