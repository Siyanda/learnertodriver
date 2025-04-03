class CreateCacheEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :cache_entries do |t|
      t.timestamps
    end
  end
end
