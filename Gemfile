source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'hotwire-rails'
gem 'jbuilder'
gem 'bootsnap', require: false

gem 'redis'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'image_processing'
gem 'aws-sdk-s3', require: false

gem 'acts_as_votable'
gem 'autoprefixer-rails'
gem 'devise'
gem 'gretel'
gem 'liquid'
gem 'sinatra'
gem 'simple_form'

gem 'friendly_id'
gem 'pagy'
gem 'ransack'
gem 'actiontext'
gem 'activestorage'

gem 'inky-rb', require: 'inky'
gem 'premailer-rails'

gem 'name_of_person'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'bullet'
  gem 'letter_opener'
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'standard'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
