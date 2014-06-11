class RemoveTypesOfBusinessFromBrands < ActiveRecord::Migration
  def up
    remove_column :brands, :types_of_business
  end

  def down
    add_column :brands, :types_of_business, :string
  end
end
