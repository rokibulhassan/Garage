# Determine the mist relevant language to use in the application
# according to a set of available locales.
#
# A complete locale is composed of a language code and a country code.
# A partial locale only has a language code.
# eg. fr-FR, fr, en, en-GB, es
class LocaleFinder
  # Accept an array of locales (complete or partial).
  # Accept a default locale.
  def initialize(locales, default_locale)
    @locales        = locales.map(&:to_s)
    @default_locale = default_locale.to_s
  end


  # Return the most relevant locale.
  def find(locale)
    return @default_locale unless locale

    codes = locale.to_s.split('-')
    language_code   = codes.first.downcase
    country_code    = codes.first.upcase
    complete_locale = "#{language_code}-#{country_code}"
    partial_locale  = "#{language_code}"

    if complete_locale.in?(@locales)
      complete_locale
    elsif partial_locale.in?(@locales)
      partial_locale
    else
      @default_locale
    end
  end
end
