class SponsorWebAddressAndChapterVideo < ActiveRecord::Migration
  def up
    add_column :sponsors, :url, :string
    add_column :chapter, :vimeo_id, :string
  end

  def down
    remove_column :sponsors, :url
    remove_column :chapter, :vimeo_id
  end
end
