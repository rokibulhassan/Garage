# This tool should find the country and the language of the user.
# It does not alter the locale used to i18n the website.
class UserLocalizer
  def initialize(user, preferred_locales)
    @user              = user
    @preferred_locales = preferred_locales
  end


  def execute
    codes = extract_codes_from_locales
    @user.language_code = codes[:language_code]
    @user.country_code  = codes[:country_code]
    true
  end


  protected

  def extract_codes_from_locales
    codes = {}

    @preferred_locales.each do |locale|
      language_code, country_code = locale.split('-')
      codes[:language_code] ||= language_code
      codes[:country_code]  ||= country_code
    end

    codes
  end
end
