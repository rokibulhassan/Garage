class DropUnits < ActiveRecord::Migration
  def up
    drop_table "units"
  end

  def down
    create_table "units" do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "unit_type_id"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.string   "name"
    end

    add_index "units", ["unit_type_id"], :name => "index_units_on_unit_type_id"
  end
end
