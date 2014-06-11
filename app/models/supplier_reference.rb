class SupplierReference < ActiveRecord::Base
  attr_accessible :name, :obsolete, :reference
  belongs_to :part
end
