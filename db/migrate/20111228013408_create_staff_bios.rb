class CreateStaffBios < ActiveRecord::Migration
  def change
    create_table :staff_bios do |t|
      t.string :name, :null => true
      t.string :title, :null => true
      t.string :twitter_screen_name, :null => true
      t.text :about, :null => true

      # staff_bios have a paperclip attachment
      t.string :portrait_file_name, :null => true
      t.string :portrait_content_type, :null => true
      t.integer :portrait_file_size, :null => true
      t.datetime :portrait_updated_at, :null => true
      
      # large format blessed photo for the website
      t.string :banner_file_name, :null => true
      t.string :banner_content_type, :null => true
      t.integer :banner_file_size, :null => true
      t.datetime :banner_updated_at, :null => true
      
      t.integer :sort, :null => true

      t.timestamps
    end

  end
end
