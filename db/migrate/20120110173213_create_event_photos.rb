class CreateEventPhotos < ActiveRecord::Migration
  def change
    create_table :event_photos do |t|

      # event_photos have a paperclip attachment
      t.string :photo_file_name, :null => false
      t.string :photo_content_type, :null => false
      t.integer :photo_file_size, :null => false
      t.datetime :photo_updated_at, :null => false
      
      t.integer :event_id, :null => false
      t.string :caption, :null => true

      t.timestamps
    end

    add_index :event_photos, :event_id
    add_foreign_key :event_photos, :events

  end
end
