class AddPhotoContentToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :photo_content, :string
  end
end
