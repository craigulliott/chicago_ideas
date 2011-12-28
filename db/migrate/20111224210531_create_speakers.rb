class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|

      t.string :name, :null => false, :limit => 150
      t.string :email, :null => true
      t.string :phone, :null => true
      
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
      
      # large format blessed photo for the website
      t.string :banner_file_name, :null => true
      t.string :banner_content_type, :null => true
      t.integer :banner_file_size, :null => true
      t.datetime :banner_updated_at, :null => true

      t.timestamps
    end
    
    add_index :speakers, :permalink, :unique => true
  end
end
