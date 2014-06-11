cargurus_brands = YAML.load(File.read(File.join(Rails.root, 'data', 'cargurus', 'brands.yml')))
cargurus_models = YAML.load(File.read(File.join(Rails.root, 'data', 'cargurus', 'models.yml')))

mobilede_brands = YAML.load(File.read(File.join(Rails.root, 'data', 'mobilede', 'brands.yml')))
mobilede_models = YAML.load(File.read(File.join(Rails.root, 'data', 'mobilede', 'models.yml')))

@vehicle_type = ENV['VEHICLE_TYPE'] || 'automobile'
@errors = {}

namespace :insert do
  task :brands_and_models => [:environment] do
    cargurus_brands.each(&method(:create_brand))
    mobilede_brands.each(&method(:create_brand))

    cargurus_models.each(&method(:create_models))
    mobilede_models.each(&method(:create_models))

    if @errors.present?
      STDERR.puts "ERRORS:"
      @errors.each do |err_on, e|
        STDERR.puts err_on, e, "\n"
      end
    else
      STDOUT.puts "success!"
    end
  end
end


def create_brand(array)
  brand_name = array.first
  model_name = array.second
  vehicle_type = @vehicle_type
  b = Brand.find_or_initialize_by_name(brand_name)
  b.vehicle_types = [vehicle_type]
  b.accept!
  begin
    b.save
    create_models([brand_name] + [[model_name]])
  rescue => e
    @errors["brand: #{brand_name}"] = e
  end
end

def create_models(array)
  brand_name = array.first
  model_names = array.second
  b = Brand.find_or_initialize_by_name(brand_name)
  b.accept!
  model_names.each do |model_name|
    begin
      model = b.models.find_or_create_by_name(model_name)
      model.accept!
      model.vehicle_type = @vehicle_type
      model.save
    rescue => e
      @errors["brand - model: #{brand_name} - #{model_name}"] = e
    end
  end
end
