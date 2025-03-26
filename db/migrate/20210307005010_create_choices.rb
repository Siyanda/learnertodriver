# frozen_string_literal: true

class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.string :name, null: false, default: 'index_active_storage_variant_records_uniqueness'
      t.string :content, null: false, default: 'index_active_storage_variant_records_uniqueness'
      t.integer :value, null: false, default: 0

      t.references :answer, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :evaluation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
