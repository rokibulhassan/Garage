class Service < ActiveRecord::Base
  attr_accessible :done_at, :duration_type, :label, :price, :service_type, :vendor, :vendor_id, :modification_id
  belongs_to :vendor
  belongs_to :modification

  SERVICE_TYPES = %w( part_removal part_installation bodywork preparation )
  assignable_values_for(:service_type, allow_blank: true) { SERVICE_TYPES }

  DURATION_TYPES = '1'..'100'
  assignable_values_for(:duration_type, allow_blank: true) { DURATION_TYPES }

  assignable_values_for(:vendor_id, allow_blank: true) { Vendor.pluck(:id) }
end
