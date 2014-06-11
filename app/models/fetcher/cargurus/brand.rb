require 'open-uri'

class Fetcher::Cargurus::Brand
  IGNORE_LIST = [ 'Select Make' ]


  # Return a hash that associated a brand name to its Mobile.de id.
  def fetch
    @brands = {}

    document.css('select[name*=maker]').last.css('option').each do |option|
      brand_name = option.text.strip
      brand_id   = option.attributes['value'].try(:content).try(:strip)

      next if brand_name.in?(IGNORE_LIST)
      @brands[brand_name] = brand_id
    end

    @brands
  end


  def document
    Nokogiri::HTML(open(url))
  end


  def url
    'http://www.cargurus.com/'
  end
end
