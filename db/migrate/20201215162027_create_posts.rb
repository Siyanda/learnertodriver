class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug
      t.references :author, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end