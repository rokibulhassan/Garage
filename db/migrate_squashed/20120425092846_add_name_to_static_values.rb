class AddNameToStaticValues < ActiveRecord::Migration
  def change
    add_column :static_values, :name, :string
  end
end
