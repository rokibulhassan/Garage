set :application, 'myygarage'

set :ssh_options, { user: "#{application}", keys: [File.join(ENV["HOME"], ".ssh", "anahoret_myy_garage.pem")], forward_agent: true }
set :branch, 'production'
set :rails_env, 'production'

set :deploy_by_user, "#{application}"
set :use_sudo, false
set :deploy_to, "/home/#{deploy_by_user}/rails_app"

set :default_environment, {
  'PATH' => "/home/#{deploy_by_user}/.rbenv/shims:/home/#{deploy_by_user}/.rbenv/bin:$PATH"
}

set :host_name, "#{application}.com"

role :web, host_name                # Your HTTP server, Apache/etc
role :app, host_name                # This may be the same as your `Web` server
role :db,  host_name, primary: true # This is where Rails migrations will run

namespace :deploy do
  desc "Start Unicorn."
  task :start, except: { no_release: true } do
    run "cd #{current_path} ; RAILS_ENV=#{rails_env} bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop Unicorn."
  task :stop, except: { no_release: true } do
    run "kill -s QUIT `cat /tmp/unicorn.#{application}.pid`"
  end

  desc "Zero-downtime restart of Unicorn."
  task :restart, except: { no_release: true } do
    run "kill -s USR2 `cat /tmp/unicorn.#{application}.pid`"
  end

  namespace :assets do
    desc 'Run the precompile task locally and rsync with shared'
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run "rm -rf #{shared_path}/assets"
      %x{bundle exec rake assets:precompile}
      %x{rsync --verbose --recursive --times --rsh='ssh -i #{ssh_options[:keys][0]}' --compress --human-readable --progress public/assets #{ssh_options[:user]}@#{host_name}:#{shared_path}}
      %x{bundle exec rake assets:clean}
    end
  end
end
