class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      
      t.string :name, :null => false, :limit => 150
      t.text :description, :null => true

      # events have an optional partner
      t.integer :partner_id, :null => true

      t.integer :day_id, :null => false
      t.integer :venue_id, :null => false

      t.time :start_time, :null => false
      t.time :end_time, :null => false

      # polymorphic (lab, party, partner_program, affiliate_event)
      t.string :type, :null => false

      t.timestamps
    end
    
    add_index :events, :day_id
    add_foreign_key :events, :days
    
    add_index :events, :venue_id
    add_foreign_key :events, :venues
    
    add_index :events, :partner_id
    add_foreign_key :events, :partners
  end
end
