# TODO: should really be called 'NewsItem', as these are the items in the
# newsfeed, not the feed itself. Should also be STI model.
class NewsFeed < ActiveRecord::Base
  TYPES = {
      Gallery            => 'create_gallery',
      Modification       => 'create_modification',
      PartPurchase       => 'create_part_purchase',
      ComparisonTable    => 'create_comparison_table',
      Vehicle            => 'create_vehicle'
  }

  GROUPED_TYPES = {
    Galleries::Picture => 'add_pictures_to_gallery',
    Comment            => 'add_comments_to_picture'
  }

  # these event items are only shown when the associated vehicle is 'approved'
  SHOW_ON_VEHICLE_APPROVED_TYPES = [Vehicle, Gallery, Modification, PartPurchase, Galleries::Picture, Comment]

  serialize :child_ids, JSON

  attr_accessible :listener, :listener_id, :initiator, :initiator_id, :event_type,
    :target, :target_id, :extras, :child_ids, :wait_on_id, :wait_on, :hidden

  belongs_to :listener, class_name: User
  belongs_to :initiator, class_name: User
  belongs_to :target, polymorphic: true
  # some event items wait for a certain object to be ready in order to allow the showing of the event items
  # that object must have a method called 'news_feed_items_showable?'.
  belongs_to :wait_on, polymorphic: true

  validate :listener, presence: true
  validate :initiator, presence: true
  validate :target, presence: true
  validate :event_type, presence: true

  validate :gallery_not_new, :if => lambda { |news| news.event_type == GROUPED_TYPES[Galleries::Picture] }

  def self.grouped
    where(:event_type => GROUPED_TYPES.values)
  end
  def self.non_grouped
    where(:event_type => TYPES.values)
  end

  def self.hidden
    where(:hidden => true)
  end
  def self.visible
    where(:hidden => false)
  end

  def self.wait_on(obj)
    where(:wait_on_type => obj.class.name, :wait_on_id => obj.id)
  end

  # use with scope
  def self.show!
    update_all(:hidden => false)
    # make sure non-Vehicle creation news items are shown first (updated_at is sooner)
    where('target_type = :type', :type => 'Vehicle').update_all(:updated_at => Time.now - 5.seconds)
    where('target_type != :type', :type => 'Vehicle').all.each(&:touch)
  end
  # use with scope
  def self.hide!
    update_all(:hidden => true)
  end

  def grouped?
    event_type.in?(GROUPED_TYPES.values)
  end
  def non_grouped?
    not grouped?
  end

  def group_instances
    return [] if non_grouped?
    target.class.news_feed_group_instance_class.where(:id => child_ids).all
  end

  def child_ids
    read_attribute(:child_ids) || []
  end

  protected

  def gallery_not_new
    gallery = target
    return if (Time.now - gallery.created_at) > Gallery::NO_LONGER_NEW_INTERVAL
    errors.add(:base, "gallery is new, so this newsfeed event is a duplicate of the 'create_new_gallery' event")
    false
  end
end
