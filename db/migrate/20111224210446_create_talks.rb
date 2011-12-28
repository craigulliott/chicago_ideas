class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      
      t.string :name, :null => false, :limit => 150
      t.text :description, :null => true

      t.integer :day_id, :null => false
      t.integer :venue_id, :null => false
      t.integer :topic_id, :null => false
      t.integer :talk_brand_id, :null => false

      t.time :start_time, :null => false
      t.time :end_time, :null => false

      # large format blessed photo for the website
      t.string :banner_file_name, :null => true
      t.string :banner_content_type, :null => true
      t.integer :banner_file_size, :null => true
      t.datetime :banner_updated_at, :null => true

      # talks can be sponsored
      t.integer :sponsor_id, :null => true

      t.timestamps
    end
    
    add_index :talks, :day_id
    add_foreign_key :talks, :days
    
    add_index :talks, :venue_id
    add_foreign_key :talks, :venues
    
    add_index :talks, :topic_id
    add_foreign_key :talks, :topics
    
    add_index :talks, :sponsor_id
    add_foreign_key :talks, :sponsors
    
    add_index :talks, :talk_brand_id
    add_foreign_key :talks, :talk_brands
    
  end
end
