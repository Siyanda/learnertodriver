# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :content, null: false
      t.integer :kind, null: false, default: 0
      t.string :information, null: false
    end
  end
end
