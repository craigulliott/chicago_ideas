class NewsletterFlag < ActiveRecord::Migration
  def up
    add_column :users, :newsletter, :boolean, :null => false, :default => true
  end

  def down
    remove_column :users, :newsletter
  end
end
