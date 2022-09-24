# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails'
gem 'pg'
gem 'puma'
gem 'jbuilder'
gem 'propshaft'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'bootsnap', require: false

gem 'redis'
gem 'sidekiq'
gem 'image_processing'
gem 'aws-sdk-s3', require: false

gem 'pagy'
gem 'liquid'
gem 'ransack'
gem 'sinatra'
gem 'pg_search'
gem 'redcarpet'
gem 'name_of_person'

gem 'devise'
gem 'gretel'
gem 'friendly_id'
gem 'simple_form'
gem 'postmark-rails'
gem 'acts_as_votable'

group :development, :test do
  gem 'debug'
  gem 'faker'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'erb_lint', require: false
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'brakeman'
  gem 'web-console'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
  gem 'selenium-webdriver'
end
