class CreateStaticValues < ActiveRecord::Migration
  def change
    create_table :static_values do |t|
      t.string :label_fr
      t.string :label_en
      t.references :field_definition

      t.timestamps
    end
    add_index :static_values, :field_definition_id
  end
end
