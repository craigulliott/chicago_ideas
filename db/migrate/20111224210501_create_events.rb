class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      
      t.string :name, :null => false, :limit => 150
      t.text :description, :null => true

      # events have an optional partner
      t.integer :partner_id, :null => true

      t.integer :day_id, :null => false
      t.integer :venue_id, :null => false
      t.integer :event_brand_id, :null => false
      
      # large format blessed photo for the website
      t.string :banner_file_name, :null => true
      t.string :banner_content_type, :null => true
      t.integer :banner_file_size, :null => true
      t.datetime :banner_updated_at, :null => true

      t.time :start_time, :null => false
      t.time :end_time, :null => false

      t.timestamps
    end
    
    add_index :events, :day_id
    add_foreign_key :events, :days
    
    add_index :events, :venue_id
    add_foreign_key :events, :venues
    
    add_index :events, :partner_id
    add_foreign_key :events, :partners
    
    add_index :events, :event_brand_id
    add_foreign_key :events, :event_brands
  end
end
