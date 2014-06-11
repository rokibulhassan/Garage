class DropUnitTypeBelongings < ActiveRecord::Migration
  def up
    drop_table "unit_type_belongings"
  end

  def down
    create_table "unit_type_belongings" do |t|
      t.integer  "unit_system_id"
      t.integer  "unit_type_id"
      t.integer  "unit_id"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end

    add_index "unit_type_belongings", ["unit_id"], :name => "index_unit_type_belongings_on_unit_id"
    add_index "unit_type_belongings", ["unit_system_id"], :name => "index_unit_type_belongings_on_unit_system_id"
    add_index "unit_type_belongings", ["unit_type_id"], :name => "index_unit_type_belongings_on_unit_type_id"
  end
end
