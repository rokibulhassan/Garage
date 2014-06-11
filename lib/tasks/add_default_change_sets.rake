namespace :db do
  desc "Add default change set to vehicles"
  task add_default_change_sets: [ :environment ] do
    Vehicle.includes(:change_sets).all.each do |vehicle|
      unless vehicle.change_sets.find_by_default true
        change_set = vehicle.change_sets.build name: ChangeSet::DEFAULT_NAME
        change_set.default = true
        change_set.save!
      end
    end
  end
end
