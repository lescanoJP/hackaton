source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

#Backend
gem 'mysql2', '~> 0.5.3'
gem 'rails', '~> 6.1', '>= 6.1.4.4'
gem 'puma', '~> 5.5', '>= 5.5.2'
gem 'bootsnap', '~> 1.9', '>= 1.9.3', require: false
gem 'admin_model', '~> 0.2.0'

# Sidekiq
gem 'sidekiq', '~> 6.3', '>= 6.3.1'
gem 'sidekiq-cron', '~> 1.2'
gem 'sidekiq-status', '~> 2.1'
gem 'redis-namespace', '~> 1.8', '>= 1.8.1'
gem 'redis', '~> 4.5', '>= 4.5.1'

# Descomentar caso sua aplicaçao for ter front-end
# Assets
gem 'sass-rails', '~> 6.0'
# https://github.com/rails/webpacker 222
gem 'webpacker', '~> 5.4', '>= 5.4.3'
# gem 'turbolinks', '~> 5'

# Facilities
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'jera_push', '~> 1.2', '>= 1.2.4'
gem 'business_process', '~> 1.0', '>= 1.0.3'
gem 'rails_admin', '~> 2.2', '>= 2.2.1'
gem 'cpf_cnpj', '~> 0.5.0'
gem 'enumerize', '~> 2.4'
gem 'faker', '~> 2.19'

# API
gem 'active_model_serializers', '~> 0.10.12'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'pagy', '~> 5.6', '>= 5.6.6'
gem 'jbuilder', '~> 2.11', '>= 2.11.5'
gem 'oj', '~> 3.13', '>= 3.13.10'
gem 'modulejs-rails', '~> 2.2'
gem 'gem-wrappers', '~> 1.4'

# Image upload
gem 'carrierwave', '~> 2.2', '>= 2.2.2'
gem 'carrierwave-aws', '~> 1.5'

# Monitoring
gem 'sentry-ruby', '~> 4.8', '>= 4.8.1'
gem 'sentry-rails', '~> 4.8', '>= 4.8.1'
gem 'newrelic_rpm', '~> 8.2'

# MR Automators
gem 'pronto', '~> 0.11.0'
gem 'pronto-rubocop', '~> 0.11.1'
gem 'reek', '~> 6.0', '>= 6.0.6'

# Facebook and Google OAuth2
gem 'koala', '~> 3.1'
gem 'google-id-token', '~> 1.4', '>= 1.4.2'
gem 'apple_id_token', '~> 0.3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.1', '>= 11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 3.36'
  gem 'nokogiri', '~> 1.12', '>= 1.12.5'
end

group :development do
  gem 'listen', '~> 3.7'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'mina', '~> 1.2', '>= 1.2.4'
  gem 'mina-sidekiq', '~> 1.1'
  gem 'bullet', '~> 7.0', '>= 6.1.5'
end

group :test do
  gem 'selenium-webdriver', '~> 4.1'
  gem 'webdrivers', '~> 5.0'
  gem 'cucumber-rails', '~> 2.4', require: false
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'shoulda', '~> 4.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2021', '>= 1.2021.5', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
