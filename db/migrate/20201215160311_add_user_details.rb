# frozen_string_literal: true

class AddUserDetails < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string   :first_name
      t.string   :last_name
      t.text     :phone_number
      t.string   :title
      t.text     :bio
      t.string   :slug
      t.text     :links
      t.date     :birthday
      t.string   :username
      t.integer  :status, default: 0, null: false
      t.integer  :role,   default: 0, null: false
    end
    add_index :users, :slug,     unique: true
    add_index :users, :username, unique: true
  end
end
