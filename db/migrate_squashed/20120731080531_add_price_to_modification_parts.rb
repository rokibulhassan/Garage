class AddPriceToModificationParts < ActiveRecord::Migration
  def change
    add_column :modification_parts, :price, :float
  end
end
