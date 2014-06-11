namespace :gather do
  namespace :mobilede do
    desc "Gather brands and models from Mobile.de."
    task brands_and_models: [ :environment ] do
      @brands = {}
      @models = {}

      fetcher = Fetcher::Mobilede::Brand.new
      @brands = fetcher.fetch

      fetcher = Fetcher::Mobilede::Model.new
      @brands.each do |brand_name, brand_id|
        @models[brand_name] = fetcher.fetch(brand_id)
      end

      file = Rails.root.join('data', 'mobilede', 'brands.yml')
      File.write(file, @brands.to_yaml)

      file = Rails.root.join('data', 'mobilede', 'models.yml')
      File.write(file, @models.to_yaml)
    end
  end


  namespace :cargurus do
    desc "Gather brands and models from Cargurus.com."
    task brands_and_models: [ :environment ] do
      @brands = {}
      @models = {}

      fetcher = Fetcher::Cargurus::Brand.new
      @brands = fetcher.fetch

      fetcher = Fetcher::Cargurus::Model.new
      @brands.each do |brand_name, brand_id|
        @models[brand_name] = fetcher.fetch(brand_id)
      end

      file = Rails.root.join('data', 'cargurus', 'brands.yml')
      File.write(file, @brands.to_yaml)

      file = Rails.root.join('data', 'cargurus', 'models.yml')
      File.write(file, @models.to_yaml)
    end
  end
end
