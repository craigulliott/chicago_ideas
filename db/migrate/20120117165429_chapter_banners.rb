class ChapterBanners < ActiveRecord::Migration
  def up
    # all other sections will propogate banners from chapters
    add_column :chapters, :banner_file_name, :string, :null => true
    add_column :chapters, :banner_content_type, :string, :null => true
    add_column :chapters, :banner_file_size, :integer, :null => true
    add_column :chapters, :banner_updated_at, :datetime, :null => true
    # remove the specific banners
    [:sponsors, :talks, :users, :partners].each do |t|
      remove_column t, :banner_file_name
      remove_column t, :banner_content_type
      remove_column t, :banner_file_size
      remove_column t, :banner_updated_at
    end
  end

  def down
    remove_column :chapters, :banner_file_name
    remove_column :chapters, :banner_content_type
    remove_column :chapters, :banner_file_size
    remove_column :chapters, :banner_updated_at
    
    [:sponsors, :talks, :users, :partners].each do |t|
      add_column t, :banner_file_name, :string, :null => true
      add_column t, :banner_content_type, :string, :null => true
      add_column t, :banner_file_size, :integer, :null => true
      add_column t, :banner_updated_at, :datetime, :null => true
    end
  end
end
