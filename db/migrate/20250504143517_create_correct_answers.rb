# frozen_string_literal: true

class CreateCorrectAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :correct_answers do |t|
      t.references :question, null: false, foreign_key: true
      t.references :answer,   null: false, foreign_key: true

      t.timestamps
    end

    add_index :correct_answers, %i[question_id answer_id], unique: true
  end
end
