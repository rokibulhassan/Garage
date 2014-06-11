class PartPurchase < ActiveRecord::Base
  attr_accessible :bought_at, :price, :quantity, :special, :vehicle_id, :vendor_id, :part_id, :modification_id, :main

  has_many :news_feeds, as: :target, dependent: :destroy

  belongs_to :vendor
  belongs_to :part
  belongs_to :vehicle
  belongs_to :modification

  delegate :label, to: :part
  delegate :user, :version, to: :vehicle

  assignable_values_for(:vehicle_id) { Vehicle.pluck(:id) }
  assignable_values_for(:part_id) { Part.pluck(:id) }
  assignable_values_for(:vendor_id) { Vendor.pluck(:id) }

  def news_feed_extra(news_feed)
    { label: part.label,
      vendor: vendor.name
    }
  end
end
