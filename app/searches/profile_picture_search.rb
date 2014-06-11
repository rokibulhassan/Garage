class ProfilePictureSearch
  PER_PAGE_LIMIT = 20

  def initialize user, opts = {}
    @user = user
    @per_page = opts[:per_page] || PER_PAGE_LIMIT
    @page = (opts[:page] || 1).to_i
    @album = opts[:album]
  end

  def profile_pictures
    if @album
      @album.pictures
    else
      @user.pictures.order(:updated_at).reverse_order.limit(@per_page).offset((@page - 1) * @per_page)
    end

  end

end
