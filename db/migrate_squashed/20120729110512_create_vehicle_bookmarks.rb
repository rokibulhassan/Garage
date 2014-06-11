class CreateVehicleBookmarks < ActiveRecord::Migration
  def change
    create_table :vehicle_bookmarks do |t|
      t.integer :user_id
      t.integer :vehicle_id

      t.timestamps
    end

    add_index :vehicle_bookmarks, [ :user_id, :vehicle_id ], unique: true, name: 'by_user_and_vehicle'
  end
end
