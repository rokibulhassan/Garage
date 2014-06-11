class AddProductionCodeFlagToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :use_production_codes, :boolean, default: false, null: false
  end
end
