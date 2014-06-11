class AddSomeContextToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :main_user, :string
    add_column :vehicles, :ownership_begin_at, :datetime
    add_column :vehicles, :ownership_ended_at, :datetime
  end
end
