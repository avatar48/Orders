source 'https://rubygems.org'
gem 'savon', '~> 2.12'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem 'awesome_print', '~> 1.8'
gem 'faraday', '~> 0.12.2'
gem 'devise'
gem 'dotenv-rails'
gem 'mysql2', '~> 0.4.9'
gem 'unicorn', '~> 5.3'
gem 'sidekiq', '~> 5.0', '>= 5.0.4'
gem 'tiny_tds'
gem 'activerecord-sqlserver-adapter'
gem 'listen', '~> 3.0.5'
gem 'axlsx', '~> 2.0'
gem "axlsx_rails"
gem 'foundation-datetimepicker-rails'
gem 'foundation-datepicker-rails'
#gem 'jquery-ui-rails'
#gem 'foundation-rails'
gem 'momentjs-rails'

gem 'foundation-rails'
gem 'autoprefixer-rails'
gem 'sidekiq-status'
gem 'nokogiri', '~> 1.7', '>= 1.7.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
#gem 'sass-rails', '~> 5.0.0'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
    gem 'capistrano',         require: false
    gem 'capistrano-rvm',     require: false
    gem 'capistrano-rails',   require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano3-puma',   require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.6', '>= 3.6.1'
#  gem 'factory_girl_rails', '~> 4.8'
  gem "factory_bot_rails"
  gem 'faker', '~> 1.8', '>= 1.8.7'
end

group :test do
  gem 'rspec-sidekiq'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails_layout'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
