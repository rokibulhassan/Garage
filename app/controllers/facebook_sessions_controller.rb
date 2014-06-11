class FacebookSessionsController < ApplicationController
  def new
    cookies[:return_url] = params[:return_url]
    redirect_to facebook_oauth.url_for_oauth_code
  end

  def callback
    if params[:code]
      begin
        access_token  = facebook_oauth.get_access_token(params[:code])
        graph_api     = Koala::Facebook::API.new(access_token)
        facebook_data = graph_api.get_object('me')
        facebook_id   = facebook_data['id']
        user          = User.find_by_facebook_id(facebook_id) || build_user(access_token, facebook_data)

        user.save!
        self.current_user = user

        redirect_to return_url

      rescue Koala::Facebook::APIError
        render :callback_invalid_code
      end
    else
      render :callback_no_code_error
    end
  end


  def build_user(access_token, facebook_data)
    language_code, country_code = facebook_data['locale'].split('_')
    locale                      = "#{language_code}-#{country_code}"

    user                        = current_user || User.new
    user.confirmed              = true
    user.first_name             = facebook_data['first_name']
    user.last_name              = facebook_data['last_name']
    user.gender                 = facebook_data['gender']
    user.locale                 = locale_finder.find(locale)
    user.country_code           = country_code
    user.language_code          = language_code
    user.username               = "#{facebook_data['username']}"
    user.facebook_id            = facebook_data['id']
    user.facebook_access_token  = access_token
    user.password               = UniqueToken.generate
    user.password_confirmation  = user.password
    user.persistence_token      = UniqueToken.generate

    if facebook_data['location']
      city_name, country_name = facebook_data['location']['name'].split(',').map(&:strip)

      if country_name.present? && country = Country.find_country_by_name(country_name)
        user.country_code = country.alpha2
      end

      if city_name.present?
        user.city = city_name
      end
    end

    user
  end


  def return_url
    cookies[:return_url] || root_url
  end
end
