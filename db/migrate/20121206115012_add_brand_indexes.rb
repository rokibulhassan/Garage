class AddBrandIndexes < ActiveRecord::Migration
  def up
    add_index :brands, :name, name: "index_brands_on_name", unique: true
    add_index :brands, :label_en, name: "index_brands_on_label_en", unique: true
    add_index :brands, :label_fr, name: "index_brands_on_label_fr", unique: true
  end

  def down
    remove_index :brands, :name
    remove_index :brands, :label_en
    remove_index :brands, :label_fr
  end
end
