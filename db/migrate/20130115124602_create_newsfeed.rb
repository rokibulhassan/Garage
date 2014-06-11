class CreateNewsfeed < ActiveRecord::Migration
  def up
    create_table :news_feeds do |t|
      t.integer  :listener_id, null: false
      t.integer  :initiator_id, null: false
      t.string   :event_type, null: false
      t.integer  :target_id, null: false
      t.string   :target_type, null: false
      t.text     :extras
      t.timestamps
    end
    add_index "news_feeds", ["target_id", "target_type"], :name => "index_news_feeds_on_target_id_and_target_type"
  end

  def down
    drop_table :news_feeds
  end
end
