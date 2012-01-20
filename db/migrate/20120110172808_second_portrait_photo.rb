class SecondPortraitPhoto < ActiveRecord::Migration
  def up
    
    # allow users to have a portrait
    add_column :users, :portrait2_file_name, :string, :null => true
    add_column :users, :portrait2_content_type, :string, :null => true
    add_column :users, :portrait2_file_size, :integer, :null => true
    add_column :users, :portrait2_updated_at, :datetime, :null => true

  end

  def down
    
    remove_column :users, :portrait2_file_name
    remove_column :users, :portrait2_content_type
    remove_column :users, :portrait2_file_size
    remove_column :users, :portrait2_updated_at

  end
end
