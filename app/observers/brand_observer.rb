class BrandObserver < ActiveRecord::Observer

  def before_validation brand
    brand.name = brand.name.downcase.titleize if brand.name
    brand.vehicle_types.delete_if &:blank?
  end

  def before_destroy brand
    !Brand.reflect_on_all_associations(:has_many).any? { |mac| brand.send(mac.name).size > 0 }
  end

end
