class CreateProductionCodes < ActiveRecord::Migration
  def change
    create_table :production_codes do |t|
      t.string :label_fr
      t.string :label_en
      t.references :model

      t.timestamps
    end
    add_index :production_codes, :model_id
  end
end
