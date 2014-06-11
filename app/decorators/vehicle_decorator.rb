class VehicleDecorator < ApplicationDecorator
  decorates :vehicle
  decorates_association :version

  def label
    "#{version.model.model.brand.name} #{version.model.model.name}"
  end
end