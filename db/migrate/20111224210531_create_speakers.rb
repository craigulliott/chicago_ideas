class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|

      t.string :name, :null => false, :limit => 150
      t.string :title, :null => true
      t.text :bio, :null => true

      t.string :permalink, :null => true, :limit => 150

      t.string :twitter_screen_name, :null => true
      t.string :facebook_page_id, :null => true
      
      # allow a speakers to have a portrait
      t.string :portrait_file_name, :null => true
      t.string :portrait_content_type, :null => true
      t.integer :portrait_file_size, :null => true
      t.datetime :portrait_updated_at, :null => true

      t.timestamps
    end
    
    add_index :speakers, :permalink, :unique => true
  end
end
