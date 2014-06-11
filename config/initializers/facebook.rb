path          = Rails.root.join('config', 'facebook.yml')
configuration = YAML.load_file(path)[Rails.env]

Application::Application.config.facebook = configuration
