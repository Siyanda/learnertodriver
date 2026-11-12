# frozen_string_literal: true

class CreateEmailSuppressions < ActiveRecord::Migration[8.1]
  def change
    create_table :email_suppressions do |t|
      t.string  :email_address, null: false
      t.integer :reason,        null: false

      t.timestamps
    end

    add_index :email_suppressions, :email_address, unique: true
  end
end
