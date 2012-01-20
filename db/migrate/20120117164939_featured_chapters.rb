class FeaturedChapters < ActiveRecord::Migration
  def up
    add_column :chapters, :featured_on_talk, :boolean, :null => false, :default => false
    add_column :chapters, :featured_on_homepage, :boolean, :null => false, :default => false
    add_column :chapters, :homepage_caption, :text
  end

  def down
    remove_column :chapters, :featured_on_talk
    remove_column :chapters, :featured_on_homepage
    remove_column :chapters, :homepage_caption
  end
end
