redis:   redis-server config/redis.conf
web:     bundle exec unicorn_rails --port $PORT
clock:   bundle exec clockwork clock.rb
sidekiq: bundle exec sidekiq >> log/sidekiq.log 2>&1
