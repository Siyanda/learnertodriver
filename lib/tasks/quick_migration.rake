# frozen_string_literal: true

namespace :quick_migration do
  desc 'Quick migration to add db columns'
  task column_add: :environment do
    ActiveRecord::Migration.add_column :tags, :title, :string unless ActiveRecord::Base.connection.column_exists?(
      'tags', 'title'
    )

    ActiveRecord::Migration.add_column :tags, :slug, :string unless ActiveRecord::Base.connection.column_exists?(
      'tags', 'slug'
    )
  end

  desc 'Quick migration to remove db columns'
  task column_remove: :environment do
    # if ActiveRecord::Base.connection.column_exists?('notifications', 'question_count')
    #   ActiveRecord::Migration.remove_column :notifications, :question_count, :integer
    # end
  end

  desc 'Quick migration to drop a table'
  task table_drop: :environment do
    drop_table(:notifications) do |t|
      # t.column :name, :string, limit: 60
      # Other fields here
    end
  end

  desc 'Quick migration to rename db columns'
  task column_rename: :environment do
    # if ActiveRecord::Base.connection.column_exists?('quizzes', 'infomation')
    #   ActiveRecord::Migration.rename_column :quizzes, :infomation, :information
    # end
  end
end
