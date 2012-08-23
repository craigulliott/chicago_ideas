class AddLabHostUrlToEvents < ActiveRecord::Migration
  
  def up
    add_column :events, :lab_host_url, :string, :null => true
  end

  def down
    remove_column :events, :lab_host_url
  end
end
