# frozen_string_literal: true

class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.decimal  :score,    null: false, default: 0.0
      t.integer  :status,   default: 0, null: false
      t.datetime :started_at
      t.datetime :completed_at

      t.references :user, foreign_key: true
      t.references :quiz, foreign_key: true

      t.references :last_choice, foreign_key: { to_table: :choices, on_delete: :nullify }

      t.timestamps
    end
  end
end
