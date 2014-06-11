class AddVehicleIdToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :vehicle_id, :integer
  end
end
