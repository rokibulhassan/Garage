class Model < ActiveRecord::Base
  attr_accessible :name, :brand_id, :vehicle_type
  attr_protected as: :admin_user

  validate :brand_id, presence: true

  belongs_to :brand
  has_many :versions
  has_many :model_select_options

  include AdminValidatable

  def full_label
    "#{self.brand.full_label} #{self.name}"
  end
end
