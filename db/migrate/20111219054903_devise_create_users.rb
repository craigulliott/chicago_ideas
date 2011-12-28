class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      t.token_authenticatable
      
      t.boolean :admin, :null => false, :default => 0
      t.boolean :speaker, :null => false, :default => 0
      
      t.string :name, :null => true
      t.string :phone, :null => true
      
      t.integer :fb_uid, :null => true, :length => 8
      t.string :fb_access_token, :null => true
      
      t.string :twitter_token, :null => true, :null => true
      t.string :twitter_secret, :null => true, :null => true
      
      t.string :title, :null => true
      t.text :bio, :null => true
      
      t.string :twitter_screen_name, :null => true

      t.string :permalink, :null => true, :limit => 150

      # allow users to have a portrait
      t.string :portrait_file_name, :null => true
      t.string :portrait_content_type, :null => true
      t.integer :portrait_file_size, :null => true
      t.datetime :portrait_updated_at, :null => true
      
      # large format photo for the website
      t.string :banner_file_name, :null => true
      t.string :banner_content_type, :null => true
      t.integer :banner_file_size, :null => true
      t.datetime :banner_updated_at, :null => true
      
      t.timestamps
      t.datetime :deleted_at
    end

    # access token is required for all users
    change_column :users, :authentication_token, :string, :null => false

    # most of the time we are including this in queries, so lets index it
    add_index :users, :deleted_at

    add_index :users, :fb_uid,              :unique => true
    add_index :users, :fb_access_token
      
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :authentication_token, :unique => true
    
    add_index :users, :permalink, :unique => true
    
  end

  def self.down
    drop_table :users
  end
end
