class CreateTalkPhotos < ActiveRecord::Migration
  def change
    create_table :talk_photos do |t|

      # talk_photos have a paperclip attachment
      t.string :photo_file_name, :null => false
      t.string :photo_content_type, :null => false
      t.integer :photo_file_size, :null => false
      t.datetime :photo_updated_at, :null => false
      
      t.integer :talk_id, :null => false
      t.string :caption, :null => true

      t.timestamps
    end

    add_index :talk_photos, :talk_id
    add_foreign_key :talk_photos, :talks

  end
end
