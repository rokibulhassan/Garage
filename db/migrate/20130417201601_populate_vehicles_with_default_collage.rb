class PopulateVehiclesWithDefaultCollage < ActiveRecord::Migration
  def up
    Vehicle.find_each do |vehicle|
      next if vehicle.collage.present?
      collage = DefaultVehicleCollage.new
      collage.vehicle_id = vehicle.id
      collage.save
    end
  end

  def down
  end
end
