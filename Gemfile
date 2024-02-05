# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails'
gem 'puma'
gem 'litestack'
gem 'pg'
gem 'sidekiq'
gem 'redis'
gem 'bootsnap', require: false

gem 'propshaft'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'dartsass-rails'
gem 'jsbundling-rails'
gem 'cssbundling-rails'

gem 'image_processing'
gem 'aws-sdk-s3', require: false

gem 'pagy'
gem 'liquid'
gem 'ransack'
gem 'redcarpet'
gem 'name_of_person'

gem 'devise'
gem 'gretel'
gem 'friendly_id'
gem 'postmark-rails'
gem 'acts_as_votable'

group :development, :test do
  gem 'debug'
  gem 'faker'
  gem 'rails_live_reload'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'rubocop-rails', require: false
  gem 'erb_lint', require: false
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'brakeman'
  gem 'web-console'
  gem 'letter_opener'
  gem 'dockerfile-rails'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end
