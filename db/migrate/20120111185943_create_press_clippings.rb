class CreatePressClippings < ActiveRecord::Migration
  def change
    create_table :press_clippings do |t|
      t.string :title, :null => false

      # press_clippings have a paperclip attachment
      t.string :image_file_name, :null => true
      t.string :image_content_type, :null => true
      t.integer :image_file_size, :null => true
      t.datetime :image_updated_at, :null => true
      
      t.string :url, :null => true
      t.text :description, :null => true

      t.timestamps
    end

  end
end
