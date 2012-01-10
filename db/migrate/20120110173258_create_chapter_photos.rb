class CreateChapterPhotos < ActiveRecord::Migration
  def change
    create_table :chapter_photos do |t|

      # chapter_photos have a paperclip attachment
      t.string :photo_file_name, :null => false
      t.string :photo_content_type, :null => false
      t.integer :photo_file_size, :null => false
      t.datetime :photo_updated_at, :null => false
      
      t.integer :chapter_id, :null => false
      t.string :caption, :null => true

      t.timestamps
    end

    add_index :chapter_photos, :chapter_id
    add_foreign_key :chapter_photos, :chapters

  end
end
