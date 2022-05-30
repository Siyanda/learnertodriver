# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content
      t.string :excerpt, default: '', null: false
      t.string :slug
      t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end
