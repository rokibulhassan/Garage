namespace :consolidate do
  desc "Consolidate files of brands."
  task :brands do
    mobilede_file = Rails.root.join('data', 'mobilede', 'brands.yml')
    mobilede_data = YAML.load_file(mobilede_file)

    cargurus_file = Rails.root.join('data', 'cargurus', 'brands.yml')
    cargurus_data = YAML.load_file(cargurus_file)

    consolidated_file = Rails.root.join('data', 'consolidated', 'brands.yml')
    consolidated_data = (mobilede_data.keys + cargurus_data.keys).uniq
    File.write(consolidated_file, consolidated_data.to_yaml)
  end


  desc "Consolidate files of models."
  task :models do
    consolidated_file = Rails.root.join('data', 'consolidated', 'models.yml')
    consolidated_data = {}

    mobilede_file = Rails.root.join('data', 'mobilede', 'models.yml')
    mobilede_data = YAML.load_file(mobilede_file)

    cargurus_file = Rails.root.join('data', 'cargurus', 'models.yml')
    cargurus_data = YAML.load_file(cargurus_file)

    # Mobile.de submodels begin with spaces. We ignore them.
    mobilede_data.each do |brand_name, models|
      consolidated_data[brand_name] ||= []
      models = models.reject { |m| m.start_with?(' ') }
      consolidated_data[brand_name] = (consolidated_data[brand_name] + models).uniq
    end

    cargurus_data.each do |brand_name, models|
      consolidated_data[brand_name] ||= []
      consolidated_data[brand_name] = (consolidated_data[brand_name] + models).uniq
    end

    File.write(consolidated_file, consolidated_data.to_yaml)
  end
end
