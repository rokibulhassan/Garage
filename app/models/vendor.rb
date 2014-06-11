class Vendor < ActiveRecord::Base
  attr_accessible :city, :country_code, :name, :street, :website, :zipcode

  validates :name, presence: true, length: 2..50

  assignable_values_for(:country_code) { Country.all.map(&:last) }
end
