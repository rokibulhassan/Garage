Deploying to Prod
=================

If deployment doesn't work properly because certain assets are missing
(js/images/css), try running:

    rake assets:precompile:all RAILS_ENV=development

This has worked for me (luke) because certain gems are part of the development
gem group that are needed for compiling certain assets. These gems, however,
should not be loaded in the production app.


Starting development:
# Fetch repo
# Create and migrate database: rake db:create db:migrate
# Load seed data: rake db:seed
# Populate test data:
## rake populate:property_definitions
## rake populate:test_data