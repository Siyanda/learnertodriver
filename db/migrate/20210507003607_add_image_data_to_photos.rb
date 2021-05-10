class AddImageDataToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :image_data, :jsonb
  end
end
