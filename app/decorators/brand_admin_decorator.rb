class BrandAdminDecorator < ApplicationDecorator
  decorates :brand
  search_methods :by_type_in
end