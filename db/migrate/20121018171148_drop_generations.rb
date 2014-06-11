class DropGenerations < ActiveRecord::Migration
  def up
    drop_table :generations
  end

  def down
    create_table "generations" do |t|
      t.integer  "production_code_id"
      t.integer  "first_year"
      t.integer  "last_year"
      t.string   "label_fr"
      t.string   "label_en"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
    end

    add_index "generations", ["production_code_id"], :name => "index_generations_on_production_code_id"
  end
end
