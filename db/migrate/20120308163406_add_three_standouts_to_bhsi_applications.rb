class AddThreeStandoutsToBhsiApplications < ActiveRecord::Migration
  def change
    add_column :bhsi_applications, :three_standout_statistics, :text, :null => false, :default => ""
  end
end
