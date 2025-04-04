# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address,   null: false
      t.string :password_digest, null: false

      t.datetime :remember_created_at

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      t.timestamps null: false
    end

    add_index :users, :email_address,      unique: true
    add_index :users, :confirmation_token, unique: true
  end
end
