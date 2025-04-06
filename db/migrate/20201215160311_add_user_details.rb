# frozen_string_literal: true

class AddUserDetails < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :title
      t.text     :bio
      t.text     :links
      t.date     :birthday
      t.string   :username
      t.text     :phone
      t.integer  :role,              default: 0, null: false
      t.integer  :status,            default: 0, null: false
      t.integer  :evaluations_count, default: 0, null: false
      t.string   :slug
    end
    add_index :users, :slug,     unique: true
    add_index :users, :username, unique: true
  end
end
