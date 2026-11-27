# frozen_string_literal: true

class CreateFlaggedIps < ActiveRecord::Migration[8.1]
  def change
    create_table :flagged_ips do |t|
      t.string  :ip_address, null: false
      t.integer :reason,     null: false

      t.timestamps
    end

    add_index :flagged_ips, :ip_address, unique: true
  end
end
