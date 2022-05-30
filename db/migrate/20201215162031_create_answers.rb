# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :name, null: false, default: ''
      t.integer :value, null: false, default: 1
      t.string :content, null: false, default: ''
      t.string :information, null: false, default: ''
      t.references :correct, foreign_key: { to_table: :answers }, index: true
    end
  end
end
