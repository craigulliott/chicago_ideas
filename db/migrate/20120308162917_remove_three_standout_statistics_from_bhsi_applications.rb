class RemoveThreeStandoutStatisticsFromBhsiApplications < ActiveRecord::Migration
  def up
    remove_column :bhsi_applications, :three_standout_statistics
  end

  def down
    change_table "bhsi_applications" do |t|
      t.text :three_standout_statistics, :null => false
    end
  end
end
