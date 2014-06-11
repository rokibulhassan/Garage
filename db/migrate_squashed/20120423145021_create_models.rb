class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.string :label_fr
      t.string :label_en
      t.references :brand

      t.timestamps
    end
    add_index :models, :brand_id
  end
end
