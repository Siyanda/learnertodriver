class AddUserDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string, null: false
    add_column :users, :links, :jsonb
    add_column :users, :bio, :text
    add_column :users, :birthday, :date
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :status, :integer, default: 0, null: false
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
  end
end
