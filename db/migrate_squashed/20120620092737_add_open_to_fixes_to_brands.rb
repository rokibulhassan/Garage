class AddOpenToFixesToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :open_to_fixes, :boolean, null: false, default: false
  end
end
