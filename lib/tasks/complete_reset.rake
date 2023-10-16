# frozen_string_literal: true

namespace :db do
  desc 'reset the database by dropping the schema'
  task complete_reset: :environment do
    raise unless Rails.env.local?

    FileUtils.rm_f('db/schema.rb')
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['dev:prime'].invoke
  end
end
