class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  before_filter :set_locale

  LANG = [["Arabic (ar)", "ar"], ["Bulgarian (bg)", "bg"], ["Czech (cs)", "cs"], ["Danish (da)", "da"], ["English (en)","en"], ["German  (de)", "de"], ["Spanish (es)", "es"], ["Persian (fa)", "fa"], ["Finnish (fi)", "fi"], ["French (fr)","fr"], ["Greek (grc)", "grc"], ["Hungarian (hu)", "hu"], ["Indonesian (id)", "id"], ["Italian (it)", "it"], ["Japanese (ja)", "ja"], ["Korean (ko)", "ko"], ["Dutch (nl)", "nl"], ["Norwegian (no)", "no"], ["Polish (pl)", "pl"], ["Portuguese (pt)", "pt"], ["Romanian (ro)", "ro"], ["Russian (ru)", "ru"], ["Slovak (sk)", "sk"], ["Swedish (sv)", "sv"], ["Turkish (tr)", "tr"], ["Vietnamese (vi)", "vi"], ["Chinese (zh)", "zh"]]

  def dashboard;end



  def bookmarklet;end

  protected
    # Try to sign the user in with the given password.
    # Return true if it succeeds, false otherwise.
    def sign_user_in(user, password)
      if user && user.authenticate(password)
        self.current_user = user
        true
      else
        false
      end
    end

    # Return the user identified in the request or nil.
    # This is based on params[:session][:identifier].
    def identified_user
      return nil if params[:session].blank?
      return nil if params[:session][:identifier].blank?

      if params[:session][:identifier].include?('@')
        return User.find_by_email(params[:session][:identifier])
      else
        return User.find_by_username(params[:session][:identifier])
      end

      nil
    end

    def given_password
      return nil if params[:session].blank?
      params[:session][:password]
    end

    helper_method :current_user
    def current_user
      @current_user ||= begin
        User.current = (persistence_token && User.find_by_persistence_token(persistence_token))
      end
    end

    def default_url_options(options = {})
      {}
    end

    def current_user=(user)
      if user
        cookies.permanent.signed[:persistence_token] = user.persistence_token
        user
      else
        cookies.delete(:persistence_token)
        nil
      end
    end

    def set_locale
      I18n.locale = if current_user
        FastGettext.set_locale "#{current_user.locale}_#{current_user.country_code}"
        current_user.locale
      else
        FastGettext.set_locale "en_GB"
        selected_locale || guessed_locale
      end
    end

    def facebook_oauth
      Koala::Facebook::OAuth.new(
        Rails.application.config.facebook['app_id'],
        Rails.application.config.facebook['app_secret'],
        facebook_sessions_callback_url
      )
    end

    def selected_locale
      cookies.signed[:locale]
    end

    def locale_finder
      LocaleFinder.new(I18n.available_locales, I18n.default_locale)
    end

    def guessed_locale
      locale_finder.find(request.user_preferred_languages.first)
    end

    def persistence_token
      cookies.signed[:persistence_token]
    end

    helper_method :public_image_url
    def public_image_url(url)
      "#{request.scheme}://#{request.host_with_port}#{url}"
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "weretesting123" && password == "myygarage9562"
      end if Rails.env.staging? || Rails.env.production?
    end

  end
