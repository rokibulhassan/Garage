class DropModificationChanges < ActiveRecord::Migration
  def up
    drop_table :modification_changes
  end

  def down
    create_table "modification_changes" do |t|
      t.integer  "modification_id"
      t.datetime "created_at",           :null => false
      t.datetime "updated_at",           :null => false
      t.string   "type"
      t.integer  "property_instance_id"
    end

    add_index "modification_changes", ["modification_id"], :name => "index_modification_changes_on_modification_id"
    add_index "modification_changes", ["property_instance_id"], :name => "index_modification_changes_on_property_instance_id"
  end
end
