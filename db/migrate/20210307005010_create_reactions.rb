class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.string :name, null: false, default: ''
      t.string :content, null: false, default: ''
      t.integer :value, null: false, default: 0
      t.integer :kind, null: false, default: 0

      t.references :answer, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
