class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :users, :author, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
