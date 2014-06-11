class AddRejectedFlagToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :rejected, :boolean, null: false, default: false
  end
end
