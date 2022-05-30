# frozen_string_literal: true

class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.decimal :score, null: false, default: 0.0
      t.string :comment, null: false, default: ''
      t.string :form_snapshot, null: false, default: ''
      t.integer :status, default: 0, null: false
      t.integer :kind, default: 0, null: false

      t.references :user, foreign_key: true
      t.references :quiz, foreign_key: true

      t.timestamps
    end
  end
end
