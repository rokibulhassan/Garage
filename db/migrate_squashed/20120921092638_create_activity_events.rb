class CreateActivityEvents < ActiveRecord::Migration
  def change
    create_table :activity_events do |t|
      t.references :actor
      t.string :type
      t.integer :target_id
      t.string :target_type
      t.text :other_data
      t.timestamps
    end

    add_index :activity_events, :actor_id
    add_index :activity_events, [ :target_id, :target_type ]
  end
end
