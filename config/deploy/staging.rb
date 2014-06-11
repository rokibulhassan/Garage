# NOTE: this server is no longer up
require "rvm/capistrano"

set :application, "myy-garage"

set :rvm_ruby_string, 'ruby-1.9.3-p125@myy_garage'
set :rvm_type, :system # defaults to using a user installation of rvm

set :ssh_options, { forward_agent: true }
set :branch, "staging"
set :rails_env, "staging"

set :deploy_by_user, ''
set :use_sudo, true

set :deploy_to, "/var/www/apps/#{application}"

set :daemon_strategy, :passenger
set :web_server,      :apache

role :web, "#{application}.anahoret.com"                          # Your HTTP server, Apache/etc
role :app, "#{application}.anahoret.com"                          # This may be the same as your `Web` server
role :db,  "#{application}.anahoret.com", primary: true # This is where Rails migrations will run

after "deploy:create_symlink", "rvm:trust_rvmrc"
after 'deploy:create_symlink', 'rvm:restart_passenger_standalone'
#after :deploy, :tagging

namespace :rvm do
  set :passenger_standalone_port, 3032

  desc "trust .rvmrc in new release directory"
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end

  desc "(Re)start Phusion Passenger Standalone (is used by Apache as a reverse proxy)."
  task :restart_passenger_standalone, :roles => :app do
    run "if [[ -s #{current_release}/tmp/pids/passenger.#{passenger_standalone_port}.pid ]]; then cd #{current_release} && passenger stop -p #{passenger_standalone_port}; fi"
    run "cd #{current_release} && passenger start -a 127.0.0.1 -p #{passenger_standalone_port} -d -e #{rails_env}"
  end
end

task :tagging do
  set :tag, "staging-#{Time.new.utc.strftime("%Y-%m-%d_%H-%M")}"
  run_locally "git checkout #{branch} && git tag #{tag} && git push origin #{tag}"
end
