class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.string :kind
      t.string :infomation
      t.integer :duration
      t.string :description, default: 3600
      t.string :string

      t.timestamps
    end
  end
end
