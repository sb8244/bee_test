class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.text :title, null: false

      t.timestamps null: false
    end
  end
end
