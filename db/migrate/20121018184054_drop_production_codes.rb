class DropProductionCodes < ActiveRecord::Migration
  def up
    drop_table :production_codes
    remove_column :versions, :production_code_id
  end

  def down
    create_table "production_codes" do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "model_id"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.string   "name"
      t.boolean  "pending",         :default => true,  :null => false
      t.boolean  "rejected",        :default => false, :null => false
      t.integer  "upvotes_count",   :default => 0,     :null => false
      t.integer  "downvotes_count", :default => 0,     :null => false
    end

    add_index "production_codes", ["model_id"], :name => "index_production_codes_on_model_id"

    add_column :versions, :production_code_id, :integer
    add_index "versions", ["production_code_id"], :name => "index_versions_on_production_code_id"
  end
end
