# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string  :title,       null: false, default: ''
      t.string  :information, null: false, default: ''
      t.integer :duration,    null: false, default: 3600
      t.string  :description, null: false, default: ''
      t.string  :slug
    end

    add_index :quizzes, :slug, unique: true
  end
end
