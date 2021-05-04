namespace :quick_migration do
  desc 'Quick migration to add db columns'
  task column_add: :environment do
    # ActiveRecord::Migration.add_column :questions, :weighting, :decimal
    unless ActiveRecord::Base.connection.column_exists?('comments', 'content')
      ActiveRecord::Migration.add_column :comments, :status, :integer
    end
    unless ActiveRecord::Base.connection.column_exists?('comments', 'content')
      ActiveRecord::Migration.add_column :comments, :content, :string
    end
    unless ActiveRecord::Base.connection.column_exists?('posts', 'content')
      ActiveRecord::Migration.add_column :posts, :content, :string
    end
    unless ActiveRecord::Base.connection.column_exists?('pages', 'content')
      ActiveRecord::Migration.add_column :pages, :content, :string
    end
  end

  desc 'Quick migration to remove db columns'
  task column_remove: :environment do
    # ActiveRecord::Migration.remove_column :questions, :weighting, :decimal
    # if ActiveRecord::Base.connection.column_exists?('quizzes', 'question_count')
    #   ActiveRecord::Migration.remove_column :quizzes, :question_count, :integer
    # end
  end

  desc 'Quick migration to rename db columns'
  task column_rename: :environment do
    # ActiveRecord::Migration.rename_column :quizzes, :infomation, :information
    if ActiveRecord::Base.connection.column_exists?('quizzes', 'infomation')
      ActiveRecord::Migration.rename_column :quizzes, :infomation, :information
    end
  end
end
