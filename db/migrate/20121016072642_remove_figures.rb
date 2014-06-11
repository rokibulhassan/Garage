class RemoveFigures < ActiveRecord::Migration
  def up
    drop_table :version_vehicle_figures
    drop_table :vehicle_figures
  end

  def down
    create_table "vehicle_figures", :force => true do |t|
      t.string   "label"
      t.string   "url"
      t.integer  "model_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer  "width"
      t.integer  "height"
    end

    create_table "version_vehicle_figures", :force => true do |t|
      t.integer  "version_id"
      t.integer  "vehicle_figure_id"
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
    end

    add_index "version_vehicle_figures", ["vehicle_figure_id"], :name => "index_version_vehicle_figures_on_vehicle_figure_id"
    add_index "version_vehicle_figures", ["version_id"], :name => "index_version_vehicle_figures_on_version_id"
    add_index "vehicle_figures", ["model_id"], :name => "index_vehicle_figures_on_model_id"
  end
end
