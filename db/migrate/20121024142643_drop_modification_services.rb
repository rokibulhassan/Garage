class DropModificationServices < ActiveRecord::Migration
  def up
    drop_table :modification_services
  end

  def down
    create_table "modification_services" do |t|
      t.integer  "modification_id"
      t.integer  "service_id"
      t.timestamps
    end
  end
end
