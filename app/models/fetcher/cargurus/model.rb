require 'open-uri'

# Fetcher to get models from Cargurus.com.
class Fetcher::Cargurus::Model
  # Return an array of models for the given Cargurus.com brand id.
  def fetch(brand_id)
    @models   = []
    @brand_id = brand_id


    document.each do |item|
      foo, bar, model_name = item.split('=')
      @models << model_name
    end

    @models
  end


  # Data from Cargurus.com is formatted like:
  # A=123=Twingo;A=456=Clio
  def document
    open(url).string.split(';')
  end


  def url
    "http://www.cargurus.com/Cars/getModelListUncached.action?showInactive=false&maker=#{@brand_id}&newCarsOnly=false&quotableOnly=false&useInventoryService=false&carsWithRegressionOnly=false"
  end
end
