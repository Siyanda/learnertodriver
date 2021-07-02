class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.references :tagable, polymorphic: true, null: false
      t.string :title
      t.text :content
      t.string :slug
      t.integer :status, default: 0, null: false
    end

    add_index :tags, :slug, unique: true
  end
end
