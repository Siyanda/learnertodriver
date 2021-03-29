class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :template
      t.string :slug
      t.references :author, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end
end
