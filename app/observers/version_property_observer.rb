class VersionPropertyObserver < ActiveRecord::Observer
  def before_update version_property
    #correction_value = version_property.with_units? ? version_property.value.round(2).to_s : version_property.value.to_s

    #if (corrector = version_property.actor)
      #correction = version_property.corrections.find_or_create_by_corrector_id corrector.id
      #correction.value = correction_value
      #correction.save
    #end

    #if corrector && !corrector.as_admin && version_property.version.approved? && version_property.corrections.where(value: correction_value).size < Settings.fixable.minimal_upvotes_count
      #version_property.value = version_property.value_was
    #end
  end
end
