source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.1'
gem 'puma'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder'
gem 'bootsnap', require: false

gem 'redis'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'image_processing'
gem 'aws-sdk-s3', require: false

gem 'inky-rb', require: 'inky'
gem 'premailer-rails'

gem 'acts_as_votable'
gem 'liquid'
gem 'devise'
gem 'friendly_id'
gem 'gretel'
gem 'name_of_person'
gem 'pagy'
gem 'ransack'
gem 'sinatra'
gem 'simple_form'

group :development, :test do
  gem 'rspec-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'bullet'
  gem 'letter_opener'
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'listen'
  gem 'spring'
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
