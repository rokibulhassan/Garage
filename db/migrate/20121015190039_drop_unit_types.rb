class DropUnitTypes < ActiveRecord::Migration
  def up
    drop_table "unit_types"
  end

  def down
    create_table "unit_types" do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
