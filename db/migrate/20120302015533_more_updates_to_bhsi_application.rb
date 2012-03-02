class MoreUpdatesToBhsiApplication < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :organizational_development, :text
      t.change :makes_social_innovation, :text
      t.change :inspiration, :text
      t.change :sustainability_model, :text
      t.change :improvements, :text
      t.change :distinguish_yourself, :text
      t.change :strong_midwest_connections_explained, :text
      t.change :additional_comments, :text
    end
  end
end
