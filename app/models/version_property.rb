class VersionProperty < ActiveRecord::Base
  attr_accessible :property_definition_id, :name, :value, :version_id
  belongs_to :version
  belongs_to :property_definition
  belongs_to :user
  has_many :corrections

  attr_accessor :is_rejected
  before_update :reset_value!, :if => lambda { |prop| prop.is_rejected == true }

  include PropertyValue

  def differential?
    false
  end

  def rejected?
    accepted == false
  end

  def pending?
    value.present? and accepted.nil?
  end

  protected

  def reset_value!
    self.value = nil
    self.user_id = nil
  end

end
