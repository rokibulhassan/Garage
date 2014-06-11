class ChangeSetObserver < ActiveRecord::Observer

  def before_update change_set
    recalculate_properties change_set
  end

  private

  def recalculate_properties change_set
    change_set.modification_properties.includes(:property_definition).group_by(&:property_definition).each do |definition, modification_properties|
      sum = modification_properties.sum {|prop| prop.value }
      change_set.properties.find_or_initialize_by_property_definition_id(definition.id).tap do |property|
        property.value = sum
      end.save
    end
  end

end
