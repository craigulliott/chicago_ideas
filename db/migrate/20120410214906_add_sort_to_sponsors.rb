class AddSortToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :sort, :integer
  end
end
