class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.references :tagable, polymorphic: true, null: false
      t.text :content
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
