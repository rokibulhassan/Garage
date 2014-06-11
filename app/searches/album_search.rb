class AlbumSearch

  PER_PAGE_LIMIT = 50

  def initialize public, user
    @public, @user = public, user
  end

  def albums
    base_relation.includes(:pictures, :cover_picture, :user).order('created_at DESC').limit(PER_PAGE_LIMIT)
  end

  private

  def base_relation
    albums = @user ? @user.albums : Album.where('user_id IS NOT NULL')
    albums = albums.where(privacy: 'public') if @public

    albums.where('vehicle_id IS NULL')
  end

end
