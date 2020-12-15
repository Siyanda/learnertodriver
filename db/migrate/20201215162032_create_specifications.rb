class CreateSpecifications < ActiveRecord::Migration[6.1]
  def change
    create_table :specifications do |t|
      t.references :question, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
