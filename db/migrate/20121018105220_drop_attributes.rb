class DropAttributes < ActiveRecord::Migration
  def up
    drop_table :attributes
  end

  def down
    create_table :attributes do |t|
      t.integer  "vehicle_id"
      t.integer  "field_definition_id"
      t.integer  "static_value_id"
      t.string   "value"
      t.integer  "dynamic_value_id"
      t.integer  "unit_id"
      t.datetime "created_at",          :null => false
      t.datetime "updated_at",          :null => false
      t.string   "dynamic_value_type"
    end

    add_index "attributes", ["field_definition_id"], :name => "index_attributes_on_field_definition_id"
    add_index "attributes", ["vehicle_id"], :name => "index_attributes_on_vehicle_id"
  end
end
