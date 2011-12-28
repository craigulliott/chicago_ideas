class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name, :null => false, :limit => 100
      t.text :description, :null => true
      
      # allow a partner to have a logo
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
  end
end
