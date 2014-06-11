class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, :polymorphic => true

  validates :user_id, :presence => true, :uniqueness => { :scope => [:likeable_type, :likeable_id] }
  validates :likeable_type, :presence => true
  validates :likeable_id, :presence => true

  def self.like(user, likeable_obj)
    like = new { |l| l.user_id = user.id }
    like.likeable = likeable_obj
    like.save
  end
end
