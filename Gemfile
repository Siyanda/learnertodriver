source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.2'
gem 'puma', '~> 5.2'
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.2'
gem 'turbolinks', '~> 5.2'
gem 'jbuilder', '~> 2.11'
gem 'bootsnap', '~> 1.7', require: false

gem 'redis', '~> 4.2'
gem 'sidekiq', '~> 6.2'
gem 'sidekiq-scheduler', '~> 3.0'
gem 'image_processing', '~> 1.12'
gem 'aws-sdk-s3', require: false

gem 'inky-rb', '~> 1.3'
gem 'premailer-rails', '~> 1.11'

gem 'acts_as_votable', '~> 0.13.1'
gem 'liquid', '~> 5.0'
gem 'devise', '~> 4.7'
gem 'friendly_id', '~> 5.4'
gem 'gretel', '~> 4.2'
gem 'name_of_person', '~> 1.1'
gem 'pagy', '~> 4.1'
gem 'ransack', '~> 2.4'
gem 'sinatra', '~> 2.1'
gem 'simple_form', '~> 5.1'

group :development, :test do
  gem 'rspec-rails', '~> 5.0'
  gem 'byebug', '~> 11.1', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'bullet', '~> 6.1'
  gem 'letter_opener', '~> 1.7'
  gem 'web-console', '~> 4.1'
  gem 'rack-mini-profiler', '~> 2.3'
  gem 'listen', '~> 3.4'
  gem 'spring', '~> 2.1'
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
