class CreateModificationChangeSets < ActiveRecord::Migration
  def change
    create_table :modification_change_sets do |t|
      t.references :modification, null: false
      t.references :change_set, null: false
    end
    add_index :modification_change_sets, [:modification_id, :change_set_id], name: :by_modification_and_change_set, unique: true
  end
end
