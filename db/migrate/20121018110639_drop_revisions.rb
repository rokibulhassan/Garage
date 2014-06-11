class DropRevisions < ActiveRecord::Migration
  def up
    drop_table :revisions
    remove_column :comparison_table_vehicles, :revision_id
    remove_column :modifications, :revision_id
  end

  def down
    create_table "revisions" do |t|
      t.integer  "vehicle_id"
      t.integer  "index"
      t.date     "date"
      t.datetime "created_at",                    :null => false
      t.datetime "updated_at",                    :null => false
      t.string   "label"
      t.boolean  "default",    :default => false, :null => false
    end
    add_column :comparison_table_vehicles, :revision_id, :integer
    add_column :modifications, :revision_id, :integer

    add_index "revisions", ["vehicle_id"], :name => "index_revisions_on_vehicle_id"
    add_index "comparison_table_vehicles", ["revision_id"], :name => "index_comparison_table_vehicles_on_revision_id"
    add_index "modifications", ["revision_id"], :name => "index_modifications_on_revision_id"
  end
end
