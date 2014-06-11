class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :label_fr
      t.string :label_en
      t.string :manufacturer_reference
      t.boolean :special, null: false, default: false
      t.references :category

      t.timestamps
    end
    add_index :parts, :category_id
  end
end
