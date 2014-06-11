class DeleteModificationParts < ActiveRecord::Migration
  def up
    drop_table :modification_parts
  end

  def down
    create_table "modification_parts" do |t|
      t.integer  "part_id"
      t.integer  "modification_id"
      t.integer  "quantity"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.boolean  "main",            :default => false, :null => false
      t.float    "price"
    end
  end
end
