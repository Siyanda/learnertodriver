source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder'
gem 'bootsnap', require: false

gem 'image_processing'
gem 'redis'
gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'devise'
gem 'gretel'
gem 'simple_form'
gem 'sinatra'

gem 'friendly_id'
gem 'pagy'
gem 'ransack'

gem 'inky-rb', require: 'inky'
gem 'premailer-rails'

gem 'name_of_person'

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
  gem 'capistrano'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]