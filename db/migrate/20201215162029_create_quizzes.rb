# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string   :title,       null: false
      t.string   :information, null: false
      t.string   :description, null: false
      t.integer  :duration,    null: false, default: 3600
      t.string   :slug
      t.datetime :published_at
    end

    add_index :quizzes, :slug, unique: true
  end
end
