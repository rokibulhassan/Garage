class Modification < ActiveRecord::Base
  attr_accessible :name

  belongs_to :vehicle, touch: true

  has_many :part_purchases
  has_many :services
  has_many :properties, class_name: "ModificationProperty"
  has_many :advantages, class_name: "ModificationProperty", conditions: { advantage: true }
  has_many :disadvantages, class_name: "ModificationProperty", conditions: { advantage: false }

  has_many :modification_change_sets
  has_many :change_sets, through: :modification_change_sets
  has_many :news_feeds, as: :target, dependent: :destroy


  delegate :user, :version, to: :vehicle

  def label
    name || "mod #{id}"
  end

  def news_feed_extra(news_feed)
    { label: label }
  end
end
