class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name, :null => false, :limit => 150
      t.text :description, :null => true

      t.integer :sponsorship_level_id, :null => false
      
      # allow a sponsor to have a logo
      t.string :logo_file_name, :null => true
      t.string :logo_content_type, :null => true
      t.integer :logo_file_size, :null => true
      t.datetime :logo_updated_at, :null => true
      
      # large format blessed photo for the website
      t.string :banner_file_name, :null => true
      t.string :banner_content_type, :null => true
      t.integer :banner_file_size, :null => true
      t.datetime :banner_updated_at, :null => true

      t.timestamps
    end

    add_index :sponsors, :sponsorship_level_id
    add_foreign_key :sponsors, :sponsorship_levels

  end
end
