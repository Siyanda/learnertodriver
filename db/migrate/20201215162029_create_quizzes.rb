class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.string :kind
      t.string :information
      t.integer :duration, default: 3600
      t.string :description
      t.string :string

      t.timestamps
    end
  end
end
