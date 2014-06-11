class Following < ActiveRecord::Base
  attr_accessible :user, :thing, :thing_id, :thing_type

  belongs_to :user
  belongs_to :thing, polymorphic: true

  def self.all_by_thing thing
    self.where thing_id: thing.id, thing_type: thing.class.to_s
  end

end
