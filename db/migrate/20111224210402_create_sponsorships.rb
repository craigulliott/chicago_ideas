class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.integer :sponsor_id, :null => false
      t.integer :year_id, :null => false
      t.integer :sponsorship_level_id, :null => false
      
      t.timestamps
    end
    
    add_index :sponsorships, [:year_id, :sponsor_id], :unique => true
    add_foreign_key :sponsorships, :years
    
    add_index :sponsorships, :sponsor_id
    add_foreign_key :sponsorships, :sponsors
    
    add_index :sponsorships, :sponsorship_level_id
    add_foreign_key :sponsorships, :sponsorship_levels
    
  end
end
