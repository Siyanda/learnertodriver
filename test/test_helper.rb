# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE'].present?
  require 'simplecov'
  SimpleCov.start 'rails'
end

require_relative '../config/environment'
require 'application_system_test_case'
require 'rails/test_help'
require 'factory_bot'

ActiveRecord::Schema.verbose = false

Rails.logger.level = :info

class ActiveSupport::TestCase
  make_my_diffs_pretty!
  fixtures :all

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_admin_as(user)
    post(admin_sign_in_url, params: { email: user.email, password: 'Secret1*3*5*' })
    user
  end
end
