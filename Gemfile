source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Active admin.
gem 'activeadmin'
gem 'formtastic', '~> 2.1.1'

# Models.
gem 'activerecord-postgresql-adapter'
gem 'squeel'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'validates_email_format_of'
gem 'default_value_for'
gem 'assignable_values'
gem 'traco', git: 'https://github.com/barsoom/traco.git' # Translate attributes.
gem 'draper'
gem 'fast_gettext'
gem 'acts_as_list'
gem 'state_machine'


# Views.
gem 'jbuilder', '1.5.3' # Dynamic keys with blocks are not yet live.
gem 'sass', '3.1.20'
gem 'haml'
gem 'haml-rails'
gem 'simple_form'
gem 'i18n-js'


# Utils.
gem 'rmagick'
gem 'uuid'                    # Generate UUID.
gem 'koala'                   # Facebook API.
gem 'http_accept_language'    # Find browser preferred language.
gem 'countries'               # Find country by name or code.
gem 'iso-639'                 # Find language by name or code.
gem 'paperclip'               # File attachments.
gem 'carrierwave'             # File attachments too.
gem 'paperclip-meta'          # Store paperclip image sizes.
gem 'therubyracer'
#gem 'nokogiri'
gem 'clockwork', require: false
gem 'sidekiq'
gem 'cancan'
gem 'settingslogic'
gem 'ruby-units'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'bourbon',      '2.1.1'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'jquery-rails', '2.0.3'

  #TODO: remove it in favor of sass and bootstrap sass
  gem 'less-rails'
  gem 'twitter-bootstrap-rails' # Bootstrap through assets pipeline.
  gem 'haml_coffee_assets'      # Haml coffee for Javascript template.
end


group :development do
  gem 'quiet_assets'
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'foreman'
end

group :development, :test do
  #gem 'debugger'
  gem 'rspec-rails'
end

group :staging do
  gem 'passenger'
end

group :production, :development do
  gem 'unicorn'
end

group :production, :staging, :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'chronic'
end

#group :test do
#  gem 'cucumber-rails', require: false
#  gem 'database_cleaner'
#  gem 'capybara', '1.1.2'
#  gem 'capybara-webkit', '0.12.1'
#  gem 'launchy'
#  gem 'pickle'
#end

gem 'mailboxer'
