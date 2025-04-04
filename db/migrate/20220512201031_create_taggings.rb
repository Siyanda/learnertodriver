# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings do |t|
      t.bigint  :taggable_id
      t.string  :taggable_type

      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end

    add_index :taggings, %i[taggable_type taggable_id]
  end
end
