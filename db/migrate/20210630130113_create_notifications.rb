# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.text       :content
      t.references :notifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
