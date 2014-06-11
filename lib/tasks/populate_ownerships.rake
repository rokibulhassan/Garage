# encoding: utf-8
namespace :populate do
  desc 'Populate vehicle ownerships'
  task ownerships: [ :environment ] do
    Vehicle.all.each do |vehicle|
      vehicle.create_ownership unless vehicle.ownership
    end
  end
end
