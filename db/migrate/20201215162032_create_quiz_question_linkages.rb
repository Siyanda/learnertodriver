# frozen_string_literal: true

class CreateQuizQuestionLinkages < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_question_linkages do |t|
      t.references :question, null: false, foreign_key: true
      t.references :quiz,     null: false, foreign_key: true

      t.timestamps
    end
  end
end
