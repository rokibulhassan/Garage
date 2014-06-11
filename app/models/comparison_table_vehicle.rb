class ComparisonTableVehicle < ActiveRecord::Base
  belongs_to :comparison_table
  belongs_to :vehicle
end
