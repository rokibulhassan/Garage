require 'open-uri'

class Fetcher::Mobilede::Brand
  # Return a hash that associated a brand name to its Mobile.de id.
  def fetch
    @brands = {}

    document.css('#selectMake1 option').each do |option|
      brand_id   = option.attributes['value'].content
      brand_name = option.text

      next if brand_name.in?(%w(Any Other))
      @brands[brand_name] = brand_id
    end

    @brands
  end


  def document
    Nokogiri::HTML(open(url))
  end


  def url
    'http://www.mobile.de/?lang=en'
  end
end
