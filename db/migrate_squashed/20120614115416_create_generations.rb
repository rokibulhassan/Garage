class CreateGenerations < ActiveRecord::Migration
  def change
    create_table :generations do |t|
      t.references :production_code
      t.integer :first_year
      t.integer :last_year
      t.string :label_fr
      t.string :label_en

      t.timestamps
    end
    add_index :generations, :production_code_id
  end
end
