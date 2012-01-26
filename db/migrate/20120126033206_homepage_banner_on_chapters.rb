class HomepageBannerOnChapters < ActiveRecord::Migration
  def up
    # all other sections will propogate banners from chapters
    add_column :chapters, :homepage_banner_file_name, :string, :null => true
    add_column :chapters, :homepage_banner_content_type, :string, :null => true
    add_column :chapters, :homepage_banner_file_size, :integer, :null => true
    add_column :chapters, :homepage_banner_updated_at, :datetime, :null => true
    
  end

  def down
    remove_column :chapters, :homepage_banner_file_name
    remove_column :chapters, :homepage_banner_content_type
    remove_column :chapters, :homepage_banner_file_size
    remove_column :chapters, :homepage_banner_updated_at
  end
end
