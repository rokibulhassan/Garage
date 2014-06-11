class ModificationProperty < ActiveRecord::Base
  attr_accessible :property_definition_id, :name, :value, :advantage, :modification_id
  belongs_to :modification
  belongs_to :property_definition

  include PropertyValue

  def differential?
    true
  end
end
