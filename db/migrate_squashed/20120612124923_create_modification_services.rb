class CreateModificationServices < ActiveRecord::Migration
  def change
    create_table :modification_services do |t|
      t.references :modification
      t.references :service

      t.timestamps
    end
    add_index :modification_services, :modification_id
    add_index :modification_services, :service_id
  end
end
