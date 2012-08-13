class AddPublishedToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :published, :boolean, :null => false, :default => 0
  end

  def down
    remove_column :users, :published
  end
end
