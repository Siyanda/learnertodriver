class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.references :tagable, polymorphic: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
