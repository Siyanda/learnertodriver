class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.text :title, null: false, unique: true
      t.string :slug
      t.integer :status, default: 0, null: false
    end

    add_index :tags, :title, unique: true
    add_index :tags, :slug, unique: true
  end
end
