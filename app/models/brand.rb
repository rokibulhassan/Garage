class Brand < ActiveRecord::Base
  attr_accessible :name, :pending, :open_to_fixes, :vehicle_types
  attr_protected as: :admin_user

  include AdminValidatable

  validates :name, uniqueness: true

  has_many :models, dependent: :destroy

  serialize :vehicle_types, Array

  scope :by_type_in, lambda {|types| where { vehicle_types.like my{"%#{types.join '%'}%"} }}

  def full_label
    self.name
  end
end
