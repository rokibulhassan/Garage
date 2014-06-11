class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :label_fr
      t.string :label_en
      t.text :types_of_business

      t.timestamps
    end
  end
end
