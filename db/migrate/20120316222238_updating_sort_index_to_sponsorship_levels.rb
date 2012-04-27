class UpdatingSortIndexToSponsorshipLevels < ActiveRecord::Migration
  def change
    change_table :sponsorship_levels do |t|
      t.remove_index :sort
    end
  end
end
