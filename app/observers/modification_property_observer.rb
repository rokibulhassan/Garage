class ModificationPropertyObserver < ActiveRecord::Observer
  def after_save modification_property
    update_modification_change_sets modification_property
  end

  def after_destroy modification_property
    update_modification_change_sets modification_property
  end

  private

  def update_modification_change_sets modification_property
    modification_property.modification.change_sets.map &:save
  end

end
