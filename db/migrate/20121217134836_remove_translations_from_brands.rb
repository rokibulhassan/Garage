class RemoveTranslationsFromBrands < ActiveRecord::Migration
  def up
    remove_column :brands, :label_en
    remove_column :brands, :label_fr
    remove_column :models, :label_en
    remove_column :models, :label_fr
  end

  def down
    add_column :brands, :label_en, :string
    add_column :brands, :label_fr, :string
    add_column :models, :label_en, :string
    add_column :models, :label_fr, :string
    add_index "brands", ["label_en"], :name => "index_brands_on_label_en", :unique => true
    add_index "brands", ["label_fr"], :name => "index_brands_on_label_fr", :unique => true
  end
end
