class ModificationObserver < ActiveRecord::Observer

  def before_destroy modification
    !modification.change_sets.any?
  end

end
