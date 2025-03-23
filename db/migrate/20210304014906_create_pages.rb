# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string  :title, null: false
      t.text    :content
      t.string  :slug
      t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true, index: true
      t.references :parent, foreign_key: { to_table: :pages }, index: true

      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end
end
