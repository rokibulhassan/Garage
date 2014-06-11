class AddCarrierwaveAvatarToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :avatar, :string
  end
end
