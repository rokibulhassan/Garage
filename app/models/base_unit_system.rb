# called 'BaseUnitSystem' because 'UnitSystem' is already taken
class BaseUnitSystem < ActiveRecord::Base
  validates :label, :uniqueness => true, :presence => true

  assignable_values_for :label, default: 'EU' do
    %w( EU UK US )
  end
end
