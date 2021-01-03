class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :content, null: false
      t.string :information, null: false
      t.references :correct, foreign_key: { to_table: :answers }, index: true
    end
  end
end