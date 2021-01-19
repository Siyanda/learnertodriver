class AddUserDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string, null: false, default: "blank"
    add_column :users, :last_name, :string, null: false, default: "blank"
    add_column :users, :name, :string, null: false
    add_column :users, :username, :string, null: false
    add_column :users, :links, :jsonb
    add_column :users, :bio, :text
    add_column :users, :birthday, :date
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
  end
end