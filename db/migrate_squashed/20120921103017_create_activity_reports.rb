class CreateActivityReports < ActiveRecord::Migration
  def change
    create_table :activity_reports do |t|
      t.references :user
      t.references :activity_event

      t.timestamps
    end
    add_index :activity_reports, :user_id
    add_index :activity_reports, :activity_event_id
  end
end
