# frozen_string_literal: true

require 'fileutils'

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

# Remove the test databases created during the run once the suite finishes.
# Parallel workers each get their own database (e.g. db/test.sqlite3_0), so
# only the main process (parallel_worker_id is nil) cleans up, after all
# workers have completed.
at_exit do
  if ActiveSupport::TestCase.parallel_worker_id.nil?
    test_db_files = Dir[Rails.root.join('db/test*.sqlite3*').to_s] +
                    Dir[Rails.root.join('storage/test_*.sqlite3*').to_s]
    FileUtils.rm_f(test_db_files)
  end
end
