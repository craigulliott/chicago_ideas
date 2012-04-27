class ChangingUploadingToBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.remove :previous_budget
      t.remove :press_clipping_1
      t.remove :press_clipping_2
      t.remove :press_clipping_3
      t.has_attached_file :previous_budget
      t.has_attached_file :press_clipping_1
      t.has_attached_file :press_clipping_2
      t.has_attached_file :press_clipping_3
    end
  end
end
