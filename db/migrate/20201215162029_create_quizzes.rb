class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string :title, null: false
      t.integer :kind, null: false, default: 0
      t.string :information, null: false, default: "blank"
      t.integer :duration, null: false, default: 3600
      t.string :description, null: false, default: "blank"
    end
  end
end