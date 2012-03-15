class AddFeaturedToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :featured, :boolean
  end
end
