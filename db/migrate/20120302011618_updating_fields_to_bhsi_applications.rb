class UpdatingFieldsToBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :about_yourself, :text
      t.change :social_venture_description, :text
      t.change :explain_number, :text
      t.change :explain_number, :text
      t.change :additional_comments, :text
      t.remove :standout_statistics
      t.remove :strong_midwest_connections
    end
  end
end
