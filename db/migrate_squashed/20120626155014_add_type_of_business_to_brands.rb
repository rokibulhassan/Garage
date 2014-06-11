class AddTypeOfBusinessToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :type_of_business, :string
  end
end
