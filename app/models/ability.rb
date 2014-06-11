class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # https://github.com/ryanb/cancan/issues/687
    #can :read, :all
    can :read, [
      User, Vehicle, Generation, Ownership, ChangeSet, Service, Picture, Comment,
      Collage, Cutout, ComparisonTable, Vehicles::IdentificationPicture, NewsFeed,
      PartPurchase, Modification
    ]

    can :manage, User, { id: user.id }
    can :manage, Vehicle, { user_id: user.id }
    can :manage, Service, modification: {vehicle: { user_id: user.id }}
    can :manage, ChangeSet,    vehicle:  { user_id: user.id }
    can :manage, Modification, vehicle:  { user_id: user.id }
    can :read, [Gallery, Album], :privacy => 'public'
    can :manage, Vehicles::IdentificationPicture do |pic|
      can? :manage, pic.vehicle
    end
    can :manage, NewsFeed do |news|
      can? :manage, news.initiator
    end

    can :manage, Gallery do |gallery|
      can? :manage, gallery.vehicle
    end
    can :manage, PartPurchase do |purchase|
      can? :manage, purchase.vehicle
    end
    can :manage, Album do |album|
      album.user == user
    end

    can :manage, Picture do |picture|
      case picture
      when Galleries::Picture
        can? :manage, picture.gallery
      when Profiles::Picture
        user.id && picture.profile_id == user.id
      when Vehicles::IdentificationPicture
        user.id && user.id == picture.user.id
      end
    end
    can :create, Comment do |comment|
      user.id && !comment.picture.user.opposer_ids.include?(user.id)
    end
    can :update, Comment, :recent? => true, :user_id => user.id
    can :destroy, Comment do |comment|
      can? :manage, comment.picture
    end
    can :manage, Collage do |collage|
      case collage
      when GalleryCollage
        can? :manage, collage.gallery
      when ProfileCollage
        user.id && collage.profile_id == user.id
      when DefaultVehicleCollage
        user.id && collage.user.id == user.id
      end
    end
    can :manage, Cutout do |cutout|
      can? :manage, cutout.collage
    end
  end
end
