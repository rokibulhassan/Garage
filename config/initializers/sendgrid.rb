path          = Rails.root.join('config', 'sendgrid.yml')
configuration = YAML.load_file(path)[Rails.env]

Application::Application.configure do
  config.sendgrid = configuration

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    authentication:       'plain',
    user_name:            Rails.application.config.sendgrid['username'],
    password:             Rails.application.config.sendgrid['password'],
    domain:               'myygarage.dev',
    address:              'smtp.sendgrid.net',
    port:                 587,
    enable_starttls_auto: true
  }
end
