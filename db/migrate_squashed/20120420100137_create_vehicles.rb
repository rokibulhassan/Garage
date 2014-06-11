class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.references :user

      t.timestamps
    end
    add_index :vehicles, :user_id
  end
end
