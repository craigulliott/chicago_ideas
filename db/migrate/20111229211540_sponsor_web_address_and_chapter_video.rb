class SponsorWebAddressAndChapterVideo < ActiveRecord::Migration
  def up
    add_column :sponsors, :url, :string
    add_column :chapters, :vimeo_id, :string
  end

  def down
    remove_column :sponsors, :url
    remove_column :chapters, :vimeo_id
  end
end
