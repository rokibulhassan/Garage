class VehicleObserver < ActiveRecord::Observer

  def before_destroy vehicle
    !Vehicle.reflect_on_all_associations(:has_many)
      .any? { |mac| vehicle.send(mac.name).size > 0 }
  end

  def after_create vehicle
    change_set = vehicle.change_sets.build name: ChangeSet::DEFAULT_NAME
    change_set.default = true
    change_set.save!

    vehicle.create_ownership
  end

end
