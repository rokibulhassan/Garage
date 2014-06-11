class CreateOwnerships < ActiveRecord::Migration
  def up
    create_table :ownerships do |t|
      t.integer :vehicle_id
      t.string :status
      t.datetime :date
      t.string :owner_name

      t.timestamps
    end

    remove_column :vehicles, :main_user
    remove_column :vehicles, :ownership_begin_at
    remove_column :vehicles, :ownership_ended_at
  end

  def down
    drop_table :ownerships

    add_column :vehicles, :main_user, :string
    add_column :vehicles, :ownership_begin_at, :datetime
    add_column :vehicles, :ownership_ended_at, :datetime
  end

end
