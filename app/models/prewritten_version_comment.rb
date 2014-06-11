class PrewrittenVersionComment < PrewrittenComment
  validates :vehicle_type, :presence => true, :inclusion => { :in => Vehicle::TYPES }

  has_many :prewritten_comment_version_users, class_name: 'PrewrittenCommentVersionUser', dependent: :destroy

  class << self
    def default_scope
      where(:vehicle_type => Vehicle::TYPES)
    end

    def for_vehicle_type(vehicle_type)
      where(:vehicle_type => vehicle_type)
    end
    def for_motorcycles
      where(:vehicle_type => Vehicle::MOTORCYCLE)
    end
    def for_automobiles
      where(:vehicle_type => Vehicle::AUTOMOBILE)
    end
    alias for_cars for_automobiles
  end

  def associate_with_user_and_version!(user, version)
    version_comment = PrewrittenCommentsVersionUser.where(:user_id => user.id, :version_id => version.id).first
    if version_comment
      version_comment.prewritten_comment_id = id
      version_comment.save!
    else
      PrewrittenCommentsVersionUser.create! do |comment|
        comment.prewritten_comment_id = id
        comment.user_id = user.id
        comment.version_id = version.id
      end
    end
  end

end
