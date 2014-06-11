class ModelObserver < ActiveRecord::Observer

  def before_destroy model
    !Model.reflect_on_all_associations(:has_many).any? { |mac| model.send(mac.name).size > 0 }
  end

end
