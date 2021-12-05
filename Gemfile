source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 7.0.0.alpha2'
gem 'pg'
gem 'puma'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'bootsnap', require: false

gem 'redis'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'shrine'
gem 'image_processing'
gem 'aws-sdk-s3', require: false

gem 'liquid'
gem 'redcarpet'
gem 'name_of_person'
gem 'pagy'
gem 'ransack', github: 'activerecord-hackery/ransack'
gem 'pg_search'
gem 'sinatra'

gem 'acts_as_votable'
gem 'autoprefixer-rails'
gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main'
gem 'gretel'
gem 'friendly_id'
gem 'simple_form'

gem 'inky-rb', require: 'inky'
gem 'premailer-rails'
gem 'sendgrid-ruby'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
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
