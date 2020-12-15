class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.string :information
      t.references :correct, foreign_key: { to_table: :answers }, index: true
      t.timestamps
    end
  end
end
