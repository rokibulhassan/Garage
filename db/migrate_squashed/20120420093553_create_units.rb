class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :label_fr
      t.string :label_en
      t.references :unit_type

      t.timestamps
    end
    add_index :units, :unit_type_id
  end
end
