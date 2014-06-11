class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :name
      t.string :label_fr
      t.string :label_en
      t.references :model

      t.timestamps
    end
    add_index :versions, :model_id
  end
end
