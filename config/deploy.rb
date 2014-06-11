require "bundler/capistrano"
require "capistrano/ext/multistage"

set :scm, :git # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "git@bitbucket.org:dave5991/myy_garage.git"
set :deploy_via, :copy
set :copy_strategy, :export
set :default_stage, :production

set :bundle_flags, "--deployment"

set :keep_releases, 5

set :install_gems, false
set :backup_database_before_migrations, true
set :bundle_without, [:development, :test, :cucumber]

after "deploy:update_code", "deploy:migrate"

namespace :deploy do
  desc "Load the initial schema - it will WIPE your database, use with care."
  task :schema_load, :roles => :db, :only => { :primary => true } do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "staging")
    schema_load_target = fetch(:schema_load_target, :latest)

    directory = case schema_load_target.to_sym
      when :current then current_path
      when :latest  then latest_release
      else raise ArgumentError, "unknown migration target #{schema_load_target.inspect}"
      end

    puts <<-EOF

************************** WARNING ***************************
If you type [yes], rake db:schema:load will WIPE your database
any other input will cancel the operation.
**************************************************************

EOF
    answer = Capistrano::CLI.ui.ask "Are you sure you want to WIPE your database?: "
    if answer == 'yes'
      run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} db:schema:load"
    else
      puts "Cancelled."
    end
  end

  desc <<-DESC
    Deploys and starts a `cold' application. This is useful if you have not \
    deployed your application before, or if your application is (for some \
    other reason) not currently running. It will deploy the code, run any \
    pending migrations, and then instead of invoking `deploy:restart', it will \
    invoke `deploy:start' to fire up the application servers.
  DESC
  task :cold do
    update
    migrate
    start
  end
end
