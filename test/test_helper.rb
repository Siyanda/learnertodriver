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

  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods
end
