class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.references :answer, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end
  end
end
