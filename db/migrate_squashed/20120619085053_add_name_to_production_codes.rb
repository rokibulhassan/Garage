class AddNameToProductionCodes < ActiveRecord::Migration
  def change
    add_column :production_codes, :name, :string
  end
end
