source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'webpacker'
gem 'jbuilder'
gem 'turbolinks'
gem 'bootsnap', require: false

gem 'sentry-raven'
gem 'skylight'

gem 'devise'
gem 'faker'

gem 'redis'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sucker_punch'

gem 'gretel'
gem 'simple_form'
gem 'sinatra'

gem 'friendly_id'
gem 'pagy'
gem 'ransack'

gem 'inky-rb', require: 'inky'
gem 'premailer-rails'

gem 'rails_admin'

gem 'awesome_print'
gem 'image_processing'

gem 'bullet', group: [:development]
gem 'shog', groups: [:development, :test]

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'letter_opener'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler'
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
