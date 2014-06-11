class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :label
      t.references :vendor
      t.string :service_type
      t.float :price
      t.date :done_at
      t.string :duration_type

      t.timestamps
    end
    add_index :services, :vendor_id
  end
end
