class Cleanup < ActiveRecord::Migration
  def up
    drop_table :static_values
  end

  def down
    create_table :static_values do |t|
      t.string :label_fr
      t.string :label_en
      t.integer :field_definition_id
      t.timestamps
      t.string :name
    end


  end
end
