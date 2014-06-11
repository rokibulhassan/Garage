class RemoveBrandsTypeOfBusiness < ActiveRecord::Migration
  def up
    remove_column :brands, :type_of_business
  end

  def down
    add_column :brands, :type_of_business, :string
  end
end
