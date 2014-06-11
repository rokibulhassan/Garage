class DropEngines < ActiveRecord::Migration
  def up
    drop_table :engines
  end

  def down
    create_table :engines do |t|
      t.string :name
      t.string :label_fr
      t.string :label_en
      t.references :model

      t.timestamps
    end
    add_index :engines, :model_id
  end
end
