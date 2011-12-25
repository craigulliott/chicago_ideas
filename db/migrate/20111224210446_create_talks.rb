class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      
      t.string :name, :null => false, :limit => 150
      t.text :description, :null => true

      t.integer :day_id, :null => false
      t.integer :venue_id, :null => false
      t.integer :topic_id, :null => false

      t.time :start_time, :null => false
      t.time :end_time, :null => false

      # polymorphic (talk, mega talk, and edison talk)
      t.string :type, :null => false

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
    
  end
end
