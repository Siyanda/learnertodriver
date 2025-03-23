# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.text :links
      t.date :birthday
      t.string :username
      t.string :slug
      t.integer :role, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.integer :evaluations_count, default: 0, null: false
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email_address

      t.timestamps
    end
    add_index :users, :slug, unique: true
    add_index :users, :username, unique: true
    add_index :users, :email_address, unique: true
    add_index :users, :confirmation_token, unique: true
  end
end
