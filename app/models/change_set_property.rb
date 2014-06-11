class ChangeSetProperty < ActiveRecord::Base
  attr_accessible :property_definition_id, :advantage, :value, :change_set_id
  belongs_to :change_set
  belongs_to :property_definition

  include PropertyValue

  def differential?
    true
  end

  def normalization_base
    change_set.vehicle.version.properties.find_by_name(self.name).presence.try(:value)
  end

end
