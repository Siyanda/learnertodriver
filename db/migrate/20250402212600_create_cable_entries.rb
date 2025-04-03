class CreateCableEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :cable_entries do |t|
      t.timestamps
    end
  end
end
