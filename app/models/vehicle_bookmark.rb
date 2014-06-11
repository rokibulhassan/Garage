class VehicleBookmark < ActiveRecord::Base
  attr_accessible :vehicle
  belongs_to :user
  belongs_to :vehicle

  assignable_values_for(:vehicle) do
    Vehicle.where { user_id.not_eq my{self.user_id} }
  end
end
