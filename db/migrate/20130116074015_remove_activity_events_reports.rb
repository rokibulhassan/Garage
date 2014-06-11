class RemoveActivityEventsReports < ActiveRecord::Migration
  def up
    drop_table :activity_events
    drop_table :activity_reports
  end

  def down
    create_table "activity_events", :force => true do |t|
      t.integer  "actor_id"
      t.string   "type"
      t.integer  "target_id"
      t.string   "target_type"
      t.text     "other_data"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end
    add_index "activity_events", ["target_id", "target_type"], :name => "index_activity_events_on_target_id_and_target_type"

    create_table "activity_reports", :force => true do |t|
      t.integer  "user_id"
      t.integer  "activity_event_id"
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
    end
  end
end
