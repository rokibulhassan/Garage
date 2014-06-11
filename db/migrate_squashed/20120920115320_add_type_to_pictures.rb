class AddTypeToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :type, :string
    execute 'UPDATE pictures SET type = "Galleries::Picture" WHERE type IS NULL'
  end
end
