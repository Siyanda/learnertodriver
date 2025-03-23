# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string  :slug
      t.text    :title,  null: false, unique: true
      t.integer :status, null: false, default: 0
    end

    add_index :tags, :title, unique: true
    add_index :tags, :slug, unique: true
  end
end
