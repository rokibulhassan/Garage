class ChangeSet < ActiveRecord::Base
  attr_accessible :name, :modification_ids

  belongs_to :vehicle
  has_many :modification_change_sets, dependent: :destroy
  has_many :modifications, through: :modification_change_sets
  has_many :part_purchases, through: :modifications
  has_many :services, through: :modifications
  has_many :properties, class_name: 'ChangeSetProperty', dependent: :destroy
  has_many :modification_properties, through: :modifications, source: :properties

  scope :without_defaults, where(default: false)

  DEFAULT_NAME = "Stock"

  def comparison_properties
    properties = self.properties.joins(:property_definition).where(property_definition: {name: ComparisonTable.comparison_attribute_names})
    properties.inject({}) do |acc, property|
      acc[property.name] = property

      acc
    end
  end

end
