require 'open-uri'

# Fetcher to get models from Mobile.de.
class Fetcher::Mobilede::Model
  IGNORE_LIST = [ 'Please select', 'Other' ]


  # Return an array of models for the given Mobile.de brand id.
  def fetch(brand_id)
    @models   = []
    @brand_id = brand_id

    # Mobile.de uses some non-printable character (hexa: A0 C2) instead of spaces.
    document.css('option').each do |option|
      model_id   = option.attributes['value'].content
      model_name = option.text.gsub(/[^[:graph:]]/, ' ')

      next if model_name.in?(IGNORE_LIST)
      @models << model_name
    end

    @models
  end


  def document
    Nokogiri::HTML(open(url))
  end


  def url
    "http://www.mobile.de/home/models.html?lang=en&makeId=#{@brand_id}"
  end
end
